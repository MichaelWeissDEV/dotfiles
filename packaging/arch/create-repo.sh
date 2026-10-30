#!/usr/bin/env bash
# Create a signed Pacman repository, without installing packages or editing pacman.conf.
set -euo pipefail
here="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
output="$(realpath -m "${1:-$here/repo}")"
input="$(realpath "${2:-$here/build}")"
: "${SIGNING_KEY:?Set SIGNING_KEY to the full GPG signing-key fingerprint}"
[[ $SIGNING_KEY =~ ^[A-Fa-f0-9]{40,64}$ ]] || { echo 'Use a full GPG fingerprint.' >&2; exit 1; }
mkdir -p "$output"
sign() {
    if [[ ! -f $1.sig || ${2:-} == force ]]; then
        gpg --batch --yes --pinentry-mode loopback --passphrase-fd 0 \
            --local-user "$SIGNING_KEY" --detach-sign "$1" <<< "${GPG_PASSPHRASE:-}"
    fi
    gpg --batch --verify "$1.sig" "$1"
}
mapfile -t packages < <(find "$input" -mindepth 2 -maxdepth 2 -type f -name '*.pkg.tar.zst' | sort)
[[ ${#packages[@]} -gt 0 ]] || { echo 'No packages built.' >&2; exit 1; }
for package in "${packages[@]}"; do
    sign "$package"
    for file in "$package" "$package.sig" "$package.source.sha256"; do
        cp "$file" "$output/"
    done
done
for database in db files; do
    if [[ -f $output/arch-dotfiles.$database.tar.gz ]]; then
        gpg --batch --verify "$output/arch-dotfiles.$database.tar.gz.sig" "$output/arch-dotfiles.$database.tar.gz"
    fi
done
repo-add --include-sigs --prevent-downgrade "$output/arch-dotfiles.db.tar.gz" "${packages[@]}"
# repo-add embeds package signatures; separately sign both database archives.
for database in arch-dotfiles.db.tar.gz arch-dotfiles.files.tar.gz; do
    sign "$output/$database" force
done
# GitHub release assets cannot be symlinks. Publish actual files at canonical URLs.
for database in db files; do
    cp --remove-destination "$output/arch-dotfiles.$database.tar.gz" "$output/arch-dotfiles.$database"
    cp --remove-destination "$output/arch-dotfiles.$database.tar.gz.sig" "$output/arch-dotfiles.$database.sig"
done
gpg --batch --armor --export "$SIGNING_KEY" > "$output/arch-dotfiles-key.asc"
printf 'Signed repository: %s\n' "$output"
