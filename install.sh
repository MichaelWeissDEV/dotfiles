#!/usr/bin/env bash
# ============================================================================
# ~/.config/install.sh - Arch Linux Dotfiles & System-Setup / Updater
# ============================================================================
# Verwendung:
#   ~/.config/install.sh            Komplettes Setup (Pakete, Submodule, OMZ, Symlinks, Services)
#   ~/.config/install.sh install    Komplettes Setup (wie ohne Argument)
#   ~/.config/install.sh update     System-, Submodul- & Plugin-Update + Symlinks prüfen
#   ~/.config/install.sh packages   Nur benötigte Arch-Pakete installieren (pacman)
#   ~/.config/install.sh links      Nur Symlinks & Verzeichnisse einrichten (ohne sudo/Netzwerk)
# ============================================================================

set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
# 2. GIT-SUBMODULE (nvim & tmux) INITIALISIEREN
# ============================================================================
setup_submodules() {
    info "Initialisiere Git-Submodule (nvim, tmux)..."
    git -C "$CONFIG_DIR" submodule update --init --recursive
    ok "Git-Submodule sind bereit."
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
setup_links() {
    info "Richte Symlinks und benötigte Benutzerverzeichnisse ein..."

    # Benötigte Ordner für Screenshots (grim) und Vim Persistent-Undo
    mkdir -p "$HOME/Downloads"
    mkdir -p "$HOME/.local/state/vim/undo"
    mkdir -p "$HOME/.local/bin"

    # Symlinks im Home-Verzeichnis
    ln -sfn "$CONFIG_DIR/zsh/zshrc"      "$HOME/.zshrc"
    ln -sfn "$CONFIG_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    ln -sfn "$CONFIG_DIR/vim/vimrc"      "$HOME/.vimrc"

    # Oh My Zsh Theme verlinken (falls ~/.oh-my-zsh existiert)
    if [[ -d "$HOME/.oh-my-zsh/custom/themes" ]]; then
        ln -sfn "$CONFIG_DIR/zsh/themes/catppuccin.zsh-theme" \
            "$HOME/.oh-my-zsh/custom/themes/catppuccin.zsh-theme"
    fi

    # Ausführbarkeitsrechte für Skripte sicherstellen
    chmod +x "$CONFIG_DIR/hypr/askpass.sh" \
             "$CONFIG_DIR/hypr/powermenu.sh" \
             "$CONFIG_DIR/install.sh" \
             "$CONFIG_DIR/install-links.sh"

    ok "Symlinks eingerichtet (~/.zshrc, ~/.tmux.conf, ~/.vimrc, catppuccin.zsh-theme)."
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
# 6. UPDATE-PROZESS (System, Dotfiles, Submodule & Zsh-Plugins aktualisieren)
# ============================================================================
update_all() {
    if command -v pacman >/dev/null 2>&1; then
        info "Aktualisiere Arch Linux Systempakete..."
        sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"
    fi

    if git -C "$CONFIG_DIR" remote | grep -q .; then
        info "Aktualisiere ~/.config Repository..."
        git -C "$CONFIG_DIR" pull --ff-only || warn "Git-Pull für ~/.config übersprungen (lokale Änderungen vorhanden)."
    fi

    info "Aktualisiere Git-Submodule (nvim & tmux)..."
    git -C "$CONFIG_DIR" submodule update --init --recursive

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
  update     Systempakete, Dotfiles, Submodule & Zsh-Plugins aktualisieren
  packages   Nur alle benötigten Arch Linux Pakete via pacman installieren
  links      Nur Symlinks (~/.zshrc, ~/.tmux.conf, ~/.vimrc) & Ordner anlegen
  help       Diese Hilfe anzeigen
EOF
}

main() {
    local cmd="${1:-install}"
    case "$cmd" in
        install|all)
            install_packages
            setup_submodules
            setup_oh_my_zsh
            setup_links
            setup_system
            ok "Setup vollständig abgeschlossen!"
            ;;
        update|upgrade)
            update_all
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
