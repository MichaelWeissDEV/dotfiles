#!/usr/bin/env bash
# ============================================================================
# ~/git/dotfiles/install.sh - Arch Linux Dotfiles & System-Setup / Updater
# ============================================================================
# Verwendung:
#   ~/git/dotfiles/install.sh            Komplettes Setup (Pakete, Subtrees, OMZ, Symlinks, Services)
#   ~/git/dotfiles/install.sh install    Komplettes Setup (wie ohne Argument)
#   ~/git/dotfiles/install.sh update     System-, Dotfiles-, Subtree- & Plugin-Update + Symlinks
#   ~/git/dotfiles/install.sh subtrees   Git-Subtrees (nvim & tmux) von Upstream aktualisieren
#   ~/git/dotfiles/install.sh packages   Nur benötigte Arch-Pakete installieren (pacman)
#   ~/git/dotfiles/install.sh links      Nur Symlinks in ~/.config & ~ einrichten (ohne sudo/Netzwerk)
# ============================================================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_TARGET="${XDG_CONFIG_HOME:-$HOME/.config}"

# Farben für übersichtliche Statusausgaben (Catppuccin Mocha)
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

info()  { printf "${BLUE}[INFO]${RESET}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${RESET}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${RESET}  %s\n" "$*"; }
error() { printf "${RED}[ERROR]${RESET} %s\n" "$*" >&2; }

# Verwaltete Konfigurationsordner, die nach ~/.config/<dir> verlinkt werden
CONFIG_DIRS=(
    foot
    fuzzel
    gtk-3.0
    gtk-4.0
    hypr
    kitty
    libfm
    nvim
    pcmanfm
    tmux
    vim
    waybar
    yazi
    zsh
)

# Git-Subtree-Remotes für nvim und tmux
NVIM_REMOTE_NAME="nvim-remote"
NVIM_REMOTE_URL="https://github.com/MichaelWeissDEV/nvim-config.git"
TMUX_REMOTE_NAME="tmux-remote"
TMUX_REMOTE_URL="https://github.com/MichaelWeissDEV/tmux-config.git"

# ============================================================================
# PAKETLISTEN (Offizielle Arch Linux Repositories)
# ============================================================================
PACMAN_PACKAGES=(
    # Hyprland & Wayland Desktop
    hyprland
    hyprlock
    hypridle
    waybar
    fuzzel
    xdg-desktop-portal-hyprland
    wl-clipboard
    grim
    slurp
    brightnessctl
    power-profiles-daemon

    # Audio (PipeWire), Netzwerk & Bluetooth
    pipewire
    pipewire-alsa
    pipewire-pulse
    pipewire-jack
    wireplumber
    gst-plugin-pipewire
    libpulse
    networkmanager
    bluez
    bluez-utils

    # Terminals & Shell-Umgebung
    kitty
    foot
    zsh
    tmux

    # Editoren & CLI-Werkzeuge
    neovim
    vim
    git
    fzf
    ripgrep
    fd
    jq
    wget
    man-db
    man-pages

    # Dateimanager, Browser & Schriftarten
    yazi
    pcmanfm
    firefox
    ttf-jetbrains-mono-nerd
    noto-fonts
)

# ============================================================================
# 1. ARCH LINUX PAKETE INSTALLIEREN
# ============================================================================
install_packages() {
    if ! command -v pacman >/dev/null 2>&1; then
        warn "pacman nicht gefunden – Paketinstallation wird übersprungen."
        return 0
    fi

    info "Installiere benötigte Arch Linux Pakete via pacman (--needed)..."
    sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"
    ok "Alle Systempakete sind installiert und aktuell."
}

# ============================================================================
# 2. GIT-SUBTREES (nvim & tmux) EINRICHTEN & AKTUALISIEREN
# ============================================================================
ensure_subtree_remotes() {
    if ! git -C "$DOTFILES_DIR" remote get-url "$NVIM_REMOTE_NAME" >/dev/null 2>&1; then
        info "Füge Git-Remote '$NVIM_REMOTE_NAME' ($NVIM_REMOTE_URL) hinzu..."
        git -C "$DOTFILES_DIR" remote add "$NVIM_REMOTE_NAME" "$NVIM_REMOTE_URL"
    fi

    if ! git -C "$DOTFILES_DIR" remote get-url "$TMUX_REMOTE_NAME" >/dev/null 2>&1; then
        info "Füge Git-Remote '$TMUX_REMOTE_NAME' ($TMUX_REMOTE_URL) hinzu..."
        git -C "$DOTFILES_DIR" remote add "$TMUX_REMOTE_NAME" "$TMUX_REMOTE_URL"
    fi
}

setup_subtrees() {
    ensure_subtree_remotes

    if [[ ! -d "$DOTFILES_DIR/nvim" ]]; then
        info "Füge nvim-Subtree hinzu..."
        git -C "$DOTFILES_DIR" subtree add --prefix=nvim "$NVIM_REMOTE_NAME" main --squash \
            -m "Add nvim config as git subtree"
    fi

    if [[ ! -d "$DOTFILES_DIR/tmux" ]]; then
        info "Füge tmux-Subtree hinzu..."
        git -C "$DOTFILES_DIR" subtree add --prefix=tmux "$TMUX_REMOTE_NAME" main --squash \
            -m "Add tmux config as git subtree"
    fi

    ok "Git-Subtrees (nvim, tmux) und Remotes sind eingerichtet."
}

update_subtrees() {
    ensure_subtree_remotes

    if [[ -n "$(git -C "$DOTFILES_DIR" status --porcelain)" ]]; then
        warn "Uncommittete Änderungen in $DOTFILES_DIR gefunden – überspringe Subtree-Pull."
        return 0
    fi

    info "Aktualisiere Git-Subtree 'nvim' von $NVIM_REMOTE_NAME/main..."
    git -C "$DOTFILES_DIR" subtree pull --prefix=nvim "$NVIM_REMOTE_NAME" main --squash \
        -m "Update nvim subtree from upstream" || warn "Subtree-Pull für nvim fehlgeschlagen."

    info "Aktualisiere Git-Subtree 'tmux' von $TMUX_REMOTE_NAME/main..."
    git -C "$DOTFILES_DIR" subtree pull --prefix=tmux "$TMUX_REMOTE_NAME" main --squash \
        -m "Update tmux subtree from upstream" || warn "Subtree-Pull für tmux fehlgeschlagen."

    ok "Git-Subtrees (nvim, tmux) sind auf dem neuesten Stand."
}

# ============================================================================
# 3. OH MY ZSH & ZSH-PLUGINS EINRICHTEN
# ============================================================================
setup_oh_my_zsh() {
    local omz_dir="$HOME/.oh-my-zsh"
    local plugins_dir="$omz_dir/custom/plugins"

    if [[ ! -d "$omz_dir" ]]; then
        info "Installiere Oh My Zsh nach ~/.oh-my-zsh..."
        git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$omz_dir"
        ok "Oh My Zsh installiert."
    else
        ok "Oh My Zsh ist bereits vorhanden."
    fi

    mkdir -p "$plugins_dir" "$omz_dir/custom/themes"

    if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
        info "Installiere Plugin zsh-autosuggestions..."
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$plugins_dir/zsh-autosuggestions"
    fi

    if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        info "Installiere Plugin zsh-syntax-highlighting..."
        git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugins_dir/zsh-syntax-highlighting"
    fi

    ok "Zsh-Plugins (zsh-autosuggestions, zsh-syntax-highlighting) sind bereit."
}

# ============================================================================
# 4. SYMLINKS, VERZEICHNISSE & DATEIRECHTE SETZEN
# ============================================================================
link_item() {
    local src="$1"
    local dst="$2"

    # Falls Ziel bereits der korrekte Symlink ist: nichts zu tun
    if [[ -L "$dst" ]]; then
        local current_target
        current_target="$(readlink "$dst")"
        if [[ "$current_target" == "$src" ]]; then
            return 0
        fi
        rm -f "$dst"
    elif [[ -e "$dst" ]]; then
        local backup="${dst}.bak.$(date +%Y%m%d_%H%M%S)"
        warn "Bestehendes Ziel '$dst' ist kein Symlink – verschiebe Backup nach '$backup'"
        mv "$dst" "$backup"
    fi

    ln -sfn "$src" "$dst"
}

setup_links() {
    info "Richte Symlinks von $DOTFILES_DIR nach $CONFIG_TARGET und $HOME ein..."

    # Benötigte Ordner für Configs, Screenshots (grim) und Vim Persistent-Undo
    mkdir -p "$CONFIG_TARGET"
    mkdir -p "$HOME/Downloads"
    mkdir -p "$HOME/.local/state/vim/undo"
    mkdir -p "$HOME/.local/bin"

    # 1. Alle verwalteten Modul-Ordner nach ~/.config/<dir> verlinken
    for dir in "${CONFIG_DIRS[@]}"; do
        if [[ -e "$DOTFILES_DIR/$dir" ]]; then
            link_item "$DOTFILES_DIR/$dir" "$CONFIG_TARGET/$dir"
        else
            warn "Verzeichnis '$DOTFILES_DIR/$dir' existiert nicht – überspringe."
        fi
    done

    # 2. Symlinks im Home-Verzeichnis (zeigen auf ~/.config/..., welches auf ~/git/dotfiles/... verweist)
    link_item "$CONFIG_TARGET/zsh/zshrc"      "$HOME/.zshrc"
    link_item "$CONFIG_TARGET/tmux/tmux.conf" "$HOME/.tmux.conf"
    link_item "$CONFIG_TARGET/vim/vimrc"      "$HOME/.vimrc"

    # 3. Oh My Zsh Theme verlinken (falls ~/.oh-my-zsh existiert)
    if [[ -d "$HOME/.oh-my-zsh/custom/themes" ]]; then
        link_item "$CONFIG_TARGET/zsh/themes/catppuccin.zsh-theme" \
            "$HOME/.oh-my-zsh/custom/themes/catppuccin.zsh-theme"
    fi

    # 4. Ausführbarkeitsrechte für Skripte sicherstellen
    chmod +x "$DOTFILES_DIR/hypr/askpass.sh" \
             "$DOTFILES_DIR/hypr/powermenu.sh" \
             "$DOTFILES_DIR/install.sh" \
             "$DOTFILES_DIR/install-links.sh"

    ok "Symlinks in $CONFIG_TARGET (${#CONFIG_DIRS[@]} Module) sowie ~/.zshrc, ~/.tmux.conf, ~/.vimrc eingerichtet."
}

# ============================================================================
# 5. SYSTEM-SERVICES & STANDARD-SHELL KONFIGURIEREN
# ============================================================================
setup_system() {
    if command -v systemctl >/dev/null 2>&1; then
        for svc in NetworkManager.service bluetooth.service power-profiles-daemon.service; do
            if systemctl list-unit-files "$svc" >/dev/null 2>&1; then
                if ! systemctl is-enabled --quiet "$svc" 2>/dev/null; then
                    info "Aktiviere System-Service: $svc"
                    sudo systemctl enable --now "$svc" || warn "Konnte $svc nicht aktivieren."
                fi
            fi
        done
    fi

    if command -v zsh >/dev/null 2>&1; then
        local current_shell
        current_shell="$(getent passwd "$USER" | cut -d: -f7)"
        local zsh_path
        zsh_path="$(command -v zsh)"
        if [[ "$current_shell" != "$zsh_path" ]]; then
            info "Setze Standard-Login-Shell auf $zsh_path..."
            chsh -s "$zsh_path" || warn "Konnte Login-Shell nicht automatisch ändern."
        fi
    fi

    ok "System-Services und Standard-Shell geprüft."
}

# ============================================================================
# 6. UPDATE-PROZESS (System, Dotfiles, Subtrees & Zsh-Plugins aktualisieren)
# ============================================================================
update_all() {
    if command -v pacman >/dev/null 2>&1; then
        info "Aktualisiere Arch Linux Systempakete..."
        sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"
    fi

    if git -C "$DOTFILES_DIR" remote get-url origin >/dev/null 2>&1; then
        info "Aktualisiere Dotfiles-Repository ($DOTFILES_DIR)..."
        git -C "$DOTFILES_DIR" pull --ff-only origin main || warn "Git-Pull für Dotfiles übersprungen (lokale Änderungen vorhanden)."
    fi

    update_subtrees

    if [[ -d "$HOME/.oh-my-zsh/.git" ]]; then
        info "Aktualisiere Oh My Zsh & Plugins..."
        git -C "$HOME/.oh-my-zsh" pull --ff-only || true
        for plugin_dir in "$HOME/.oh-my-zsh/custom/plugins"/*; do
            if [[ -d "$plugin_dir/.git" ]]; then
                git -C "$plugin_dir" pull --ff-only || true
            fi
        done
    fi

    setup_links
    ok "Komplettes Update erfolgreich abgeschlossen!"
}

# ============================================================================
# HAUPTPROGRAMM
# ============================================================================
usage() {
    cat <<EOF
Verwendung: $(basename "$0") [BEFEHL]

Befehle:
  install    Komplettes Setup auf einem Arch-System (Standard, wenn kein Befehl angegeben)
  update     Systempakete, Dotfiles, Git-Subtrees (nvim/tmux) & Zsh-Plugins aktualisieren
  subtrees   Git-Subtrees (nvim & tmux) von ihren Upstream-Repositories aktualisieren
  packages   Nur alle benötigten Arch Linux Pakete via pacman installieren
  links      Nur Symlinks in ~/.config & ~ (~/.zshrc, ~/.tmux.conf, ~/.vimrc) anlegen
  help       Diese Hilfe anzeigen
EOF
}

main() {
    local cmd="${1:-install}"
    case "$cmd" in
        install|all)
            install_packages
            setup_subtrees
            setup_oh_my_zsh
            setup_links
            setup_system
            ok "Setup vollständig abgeschlossen!"
            ;;
        update|upgrade)
            update_all
            ;;
        subtrees|subtree)
            update_subtrees
            ;;
        packages|pkgs)
            install_packages
            ;;
        links|symlinks)
            setup_links
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            error "Unbekannter Befehl: $cmd"
            usage
            exit 1
            ;;
    esac
}

main "$@"
