#!/usr/bin/env bash
# Install signed Arch dotfiles packages; never clone development sources into a home.
set -euo pipefail
umask 022
repository=MichaelWeissDEV/dotfiles
fingerprint=5635E5E93F5BA18D8868AAB5A8DD63927F151C4D
yes=false
activate=true
sync=true
dry_run=false
packages=()
usage() {
    cat <<'HELP'
Arch Dotfiles installer (run as your normal user, not root)
  bash install.sh                         Install the full environment
  bash install.sh nvim tmux               Install selected configuration packages
  bash install.sh --yes                   Accept pacman prompts
  bash install.sh --no-activate            Only install packages
  bash install.sh --no-sync                Do not enable the user sync timer
  bash install.sh --dry-run nvim           Print the plan without making changes

Existing settings are backed up. Personal edits are retained with .pacnew defaults.
No login shell or system services are changed. The optional user sync timer is enabled.
HELP
}
for argument in "$@"; do
    case "$argument" in
        -h|--help) usage; exit 0 ;;
        -y|--yes) yes=true ;;
        --no-activate) activate=false ;;
        --no-sync) sync=false ;;
        --dry-run) dry_run=true ;;
        arch-dotfiles|arch-dotfiles-*) packages+=("$argument") ;;
        [a-z0-9]*) packages+=("arch-dotfiles-$argument") ;;
        *) echo "Unknown option: $argument" >&2; exit 2 ;;
    esac
done
[[ ${#packages[@]} -gt 0 ]] || packages=(arch-dotfiles)
for package in "${packages[@]}"; do
    [[ $package =~ ^arch-dotfiles(-[a-z0-9][a-z0-9.-]*)?$ ]] || { echo "Invalid package: $package" >&2; exit 2; }
done
server="https://github.com/$repository/releases/download/repo"
if $dry_run; then
    printf 'Repository: %s\nSigning fingerprint: %s\n' "$server" "$fingerprint"
    printf 'Install with a full system upgrade: pacman -Syu --needed %s\n' "${packages[*]}"
    printf 'Activate user configs: %s\nEnable user sync timer: %s\n' "$activate" "$sync"
    exit 0
fi
[[ $EUID -ne 0 ]] || { echo 'Run as your normal user with sudo available, not as root.' >&2; exit 1; }
for command in pacman pacman-key sudo curl gpg grep awk cmp tee install mktemp mkdir; do
    command -v "$command" >/dev/null || { echo "Required command missing: $command" >&2; exit 1; }
done
if ! $yes && [[ ! -t 1 ]]; then
    # Piping the script is supported; interactive package prompts use /dev/tty.
    [[ -r /dev/tty ]] || { echo 'No terminal available; use --yes for unattended installation.' >&2; exit 1; }
fi
pacman_conf=/etc/pacman.conf
repo_conf=/etc/pacman.d/arch-dotfiles.conf
include="Include = $repo_conf"
if grep -Eq '^[[:space:]]*\[arch-dotfiles\]' "$pacman_conf"; then
    echo "An inline [arch-dotfiles] section already exists in $pacman_conf." >&2
    echo "Review it and replace it with '$include' before using this installer." >&2
    exit 1
fi
temporary="$(mktemp -d)"
cleanup() {
    # Only this installer-created directory is removed.
    rm -rf -- "$temporary"
}
trap cleanup EXIT
mkdir -m700 "$temporary/gnupg"
curl --fail --silent --show-error --location --proto '=https' \
    "$server/arch-dotfiles-key.asc" -o "$temporary/key.asc"
actual="$(gpg --batch --homedir "$temporary/gnupg" --show-keys --with-colons "$temporary/key.asc" 2>/dev/null | awk -F: '$1=="fpr" { print $10; exit }')"
[[ $actual == "$fingerprint" ]] || { echo 'Repository signing-key fingerprint mismatch; aborting.' >&2; exit 1; }
cat > "$temporary/repository.conf" <<EOF
[arch-dotfiles]
SigLevel = Required DatabaseRequired
Server = $server
EOF
if [[ -f $repo_conf ]] && ! cmp -s "$temporary/repository.conf" "$repo_conf"; then
    echo "$repo_conf contains different settings; review it manually. Nothing was changed." >&2
    exit 1
fi
sudo -v
sudo pacman-key --add "$temporary/key.asc"
sudo pacman-key --lsign-key "$fingerprint"
sudo install -m644 "$temporary/repository.conf" "$repo_conf"
if ! grep -Eq '^[[:space:]]*Include[[:space:]]*=[[:space:]]*/etc/pacman.d/arch-dotfiles.conf[[:space:]]*$' "$pacman_conf"; then
    printf '\n%s\n' "$include" | sudo tee -a "$pacman_conf" >/dev/null
fi
if $yes; then
    sudo pacman -Syu --needed --noconfirm "${packages[@]}"
else
    sudo pacman -Syu --needed "${packages[@]}" </dev/tty
fi
if $activate && compgen -G '/usr/share/arch-dotfiles/modules.d/*' >/dev/null; then
    arch-dotfiles-config activate
    if $sync; then
        if ! systemctl --user enable --now arch-dotfiles-sync.timer; then
            echo 'Packages installed. Enable user sync later: systemctl --user enable --now arch-dotfiles-sync.timer' >&2
        fi
    fi
fi
printf '\nInstalled. Future updates: sudo pacman -Syu\n'
printf 'User defaults sync within about two minutes; manual sync: adot sync\n'
