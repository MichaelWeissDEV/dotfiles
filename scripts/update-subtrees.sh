#!/usr/bin/env bash
# ============================================================================
# ~/git/dotfiles/scripts/update-subtrees.sh - Git-Subtrees (nvim & tmux) verwalten
# ============================================================================
# Verwendung:
#   ~/git/dotfiles/scripts/update-subtrees.sh              Alle Subtrees (nvim & tmux) pullen
#   ~/git/dotfiles/scripts/update-subtrees.sh all          Alle Subtrees (nvim & tmux) pullen
#   ~/git/dotfiles/scripts/update-subtrees.sh nvim         Nur nvim-Subtree von Upstream pullen
#   ~/git/dotfiles/scripts/update-subtrees.sh tmux         Nur tmux-Subtree von Upstream pullen
#   ~/git/dotfiles/scripts/update-subtrees.sh push [ziel]  Lokale Subtree-Commits nach Upstream pushen
#   ~/git/dotfiles/scripts/update-subtrees.sh setup        Remotes & Subtrees initial einrichten
# ============================================================================

set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPTS_DIR/.." && pwd)"

# Farben (Catppuccin Mocha)
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

info()  { printf "${BLUE}[INFO]${RESET}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${RESET}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${RESET}  %s\n" "$*"; }
error() { printf "${RED}[ERROR]${RESET} %s\n" "$*" >&2; }

# Subtree-Konfiguration
NVIM_PREFIX="nvim"
NVIM_REMOTE_NAME="nvim-remote"
NVIM_REMOTE_URL="https://github.com/MichaelWeissDEV/nvim-config.git"
NVIM_BRANCH="main"

TMUX_PREFIX="tmux"
TMUX_REMOTE_NAME="tmux-remote"
TMUX_REMOTE_URL="https://github.com/MichaelWeissDEV/tmux-config.git"
TMUX_BRANCH="main"

ensure_remotes() {
    if ! git -C "$DOTFILES_DIR" remote get-url "$NVIM_REMOTE_NAME" >/dev/null 2>&1; then
        info "Füge Git-Remote '$NVIM_REMOTE_NAME' ($NVIM_REMOTE_URL) hinzu..."
        git -C "$DOTFILES_DIR" remote add "$NVIM_REMOTE_NAME" "$NVIM_REMOTE_URL"
    else
        git -C "$DOTFILES_DIR" remote set-url "$NVIM_REMOTE_NAME" "$NVIM_REMOTE_URL"
    fi

    if ! git -C "$DOTFILES_DIR" remote get-url "$TMUX_REMOTE_NAME" >/dev/null 2>&1; then
        info "Füge Git-Remote '$TMUX_REMOTE_NAME' ($TMUX_REMOTE_URL) hinzu..."
        git -C "$DOTFILES_DIR" remote add "$TMUX_REMOTE_NAME" "$TMUX_REMOTE_URL"
    else
        git -C "$DOTFILES_DIR" remote set-url "$TMUX_REMOTE_NAME" "$TMUX_REMOTE_URL"
    fi
}

check_clean_worktree() {
    if [[ -n "$(git -C "$DOTFILES_DIR" status --porcelain)" ]]; then
        error "Arbeitsverzeichnis in $DOTFILES_DIR hat uncommittete Änderungen!"
        warn "Bitte zuerst alle Änderungen committen oder stashen, bevor Subtrees aktualisiert werden."
        return 1
    fi
    return 0
}

setup_subtrees() {
    ensure_remotes

    if [[ ! -d "$DOTFILES_DIR/$NVIM_PREFIX" ]]; then
        info "Füge Subtree '$NVIM_PREFIX' von $NVIM_REMOTE_NAME/$NVIM_BRANCH hinzu..."
        git -C "$DOTFILES_DIR" subtree add --prefix="$NVIM_PREFIX" "$NVIM_REMOTE_NAME" "$NVIM_BRANCH" --squash \
            -m "Add nvim config as git subtree"
    fi

    if [[ ! -d "$DOTFILES_DIR/$TMUX_PREFIX" ]]; then
        info "Füge Subtree '$TMUX_PREFIX' von $TMUX_REMOTE_NAME/$TMUX_BRANCH hinzu..."
        git -C "$DOTFILES_DIR" subtree add --prefix="$TMUX_PREFIX" "$TMUX_REMOTE_NAME" "$TMUX_BRANCH" --squash \
            -m "Add tmux config as git subtree"
    fi

    ok "Git-Subtrees (nvim, tmux) und Remotes sind eingerichtet."
}

pull_nvim() {
    ensure_remotes
    check_clean_worktree || return 1
    info "Hole neueste Commits von $NVIM_REMOTE_NAME ($NVIM_REMOTE_URL)..."
    git -C "$DOTFILES_DIR" fetch "$NVIM_REMOTE_NAME" "$NVIM_BRANCH"
    info "Aktualisiere Git-Subtree '$NVIM_PREFIX'..."
    git -C "$DOTFILES_DIR" subtree pull --prefix="$NVIM_PREFIX" "$NVIM_REMOTE_NAME" "$NVIM_BRANCH" --squash \
        -m "Update nvim subtree from upstream"
    ok "Subtree '$NVIM_PREFIX' erfolgreich aktualisiert."
}

pull_tmux() {
    ensure_remotes
    check_clean_worktree || return 1
    info "Hole neueste Commits von $TMUX_REMOTE_NAME ($TMUX_REMOTE_URL)..."
    git -C "$DOTFILES_DIR" fetch "$TMUX_REMOTE_NAME" "$TMUX_BRANCH"
    info "Aktualisiere Git-Subtree '$TMUX_PREFIX'..."
    git -C "$DOTFILES_DIR" subtree pull --prefix="$TMUX_PREFIX" "$TMUX_REMOTE_NAME" "$TMUX_BRANCH" --squash \
        -m "Update tmux subtree from upstream"
    ok "Subtree '$TMUX_PREFIX' erfolgreich aktualisiert."
}

push_subtree() {
    local target="${1:-all}"
    ensure_remotes

    case "$target" in
        nvim)
            info "Pushe Änderungen aus '$NVIM_PREFIX/' nach $NVIM_REMOTE_NAME/$NVIM_BRANCH..."
            git -C "$DOTFILES_DIR" subtree push --prefix="$NVIM_PREFIX" "$NVIM_REMOTE_NAME" "$NVIM_BRANCH"
            ok "Subtree '$NVIM_PREFIX' erfolgreich nach Upstream gepusht."
            ;;
        tmux)
            info "Pushe Änderungen aus '$TMUX_PREFIX/' nach $TMUX_REMOTE_NAME/$TMUX_BRANCH..."
            git -C "$DOTFILES_DIR" subtree push --prefix="$TMUX_PREFIX" "$TMUX_REMOTE_NAME" "$TMUX_BRANCH"
            ok "Subtree '$TMUX_PREFIX' erfolgreich nach Upstream gepusht."
            ;;
        all)
            push_subtree nvim
            push_subtree tmux
            ;;
        *)
            error "Unbekanntes Push-Ziel: $target (erlaubt: nvim, tmux, all)"
            exit 1
            ;;
    esac
}

usage() {
    cat <<EOF
Verwendung: $(basename "$0") [BEFEHL]

Befehle:
  all             Beide Git-Subtrees (nvim & tmux) von Upstream aktualisieren (Standard)
  nvim            Nur den nvim-Subtree (MichaelWeissDEV/nvim-config) aktualisieren
  tmux            Nur den tmux-Subtree (MichaelWeissDEV/tmux-config) aktualisieren
  push [ziel]     Lokale Commits zurück ans Upstream-Repo pushen (nvim, tmux oder all)
  setup           Git-Remotes (nvim-remote, tmux-remote) & Subtrees initial prüfen/anlegen
  help            Diese Hilfe anzeigen
EOF
}

main() {
    local cmd="${1:-all}"
    case "$cmd" in
        all|pull|update)
            pull_nvim
            pull_tmux
            ok "Alle Git-Subtrees (nvim, tmux) sind auf dem neuesten Stand!"
            ;;
        nvim)
            pull_nvim
            ;;
        tmux)
            pull_tmux
            ;;
        push)
            push_subtree "${2:-all}"
            ;;
        setup|init)
            setup_subtrees
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
