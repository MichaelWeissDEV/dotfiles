#!/usr/bin/env bash
# ============================================================================
# ~/git/dotfiles/scripts/update-subtrees.sh - Git-Subtrees verwalten
# Verwaltete Subtrees:
#   - nvim    -> https://github.com/MichaelWeissDEV/nvim-config.git
#   - tmux    -> https://github.com/MichaelWeissDEV/tmux-config.git
#   - ghostty -> https://github.com/MichaelWeissDEV/ghostty-config.git
#   - kitty   -> https://github.com/MichaelWeissDEV/kittiy-config.git
#   - vim     -> https://github.com/MichaelWeissDEV/vim-config.git
# ============================================================================
# Verwendung:
#   ~/git/dotfiles/scripts/update-subtrees.sh                   Alle 5 Subtrees von Upstream pullen
#   ~/git/dotfiles/scripts/update-subtrees.sh all               Alle 5 Subtrees von Upstream pullen
#   ~/git/dotfiles/scripts/update-subtrees.sh <modul>           Einzelnen Subtree pullen (nvim|tmux|ghostty|kitty|vim)
#   ~/git/dotfiles/scripts/update-subtrees.sh push [ziel]       Lokale Subtree-Commits nach Upstream pushen (all oder <modul>)
#   ~/git/dotfiles/scripts/update-subtrees.sh setup             Alle 5 Git-Remotes & Subtrees prüfen/einrichten
#   ~/git/dotfiles/scripts/update-subtrees.sh status            Remote-URLs & Upstream-Status aller 5 Subtrees anzeigen
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

# Alle verwalteten Subtree-Module in fester Reihenfolge
SUBTREE_MODULES=(nvim tmux ghostty kitty vim)

get_remote_name() {
    case "$1" in
        nvim)    echo "nvim-remote" ;;
        tmux)    echo "tmux-remote" ;;
        ghostty) echo "ghostty-remote" ;;
        kitty)   echo "kitty-remote" ;;
        vim)     echo "vim-remote" ;;
        *)       return 1 ;;
    esac
}

get_remote_url() {
    case "$1" in
        nvim)    echo "https://github.com/MichaelWeissDEV/nvim-config.git" ;;
        tmux)    echo "https://github.com/MichaelWeissDEV/tmux-config.git" ;;
        ghostty) echo "https://github.com/MichaelWeissDEV/ghostty-config.git" ;;
        kitty)   echo "https://github.com/MichaelWeissDEV/kittiy-config.git" ;;
        vim)     echo "https://github.com/MichaelWeissDEV/vim-config.git" ;;
        *)       return 1 ;;
    esac
}

get_branch() {
    echo "main"
}

ensure_remotes() {
    for mod in "${SUBTREE_MODULES[@]}"; do
        local remote_name remote_url
        remote_name="$(get_remote_name "$mod")"
        remote_url="$(get_remote_url "$mod")"

        if ! git -C "$DOTFILES_DIR" remote get-url "$remote_name" >/dev/null 2>&1; then
            info "Füge Git-Remote '$remote_name' ($remote_url) hinzu..."
            git -C "$DOTFILES_DIR" remote add "$remote_name" "$remote_url"
        else
            git -C "$DOTFILES_DIR" remote set-url "$remote_name" "$remote_url"
        fi
    done
}

check_clean_worktree() {
    if [[ -n "$(git -C "$DOTFILES_DIR" status --porcelain)" ]]; then
        error "Arbeitsverzeichnis in $DOTFILES_DIR hat uncommittete Änderungen!"
        warn "Bitte zuerst alle Änderungen committen oder stashen, bevor Subtrees aktualisiert werden."
        return 1
    fi
    return 0
}

remote_has_branch() {
    local remote_name="$1"
    local branch="$2"
    local out
    out="$(GIT_TERMINAL_PROMPT=0 git -C "$DOTFILES_DIR" ls-remote --heads "$remote_name" "$branch" 2>/dev/null || true)"
    [[ -n "$out" ]]
}

setup_subtrees() {
    ensure_remotes

    for mod in "${SUBTREE_MODULES[@]}"; do
        local remote_name branch
        remote_name="$(get_remote_name "$mod")"
        branch="$(get_branch "$mod")"

        if [[ ! -d "$DOTFILES_DIR/$mod" ]]; then
            if remote_has_branch "$remote_name" "$branch"; then
                info "Füge Subtree '$mod' von $remote_name/$branch hinzu..."
                git -C "$DOTFILES_DIR" fetch "$remote_name" "$branch"
                git -C "$DOTFILES_DIR" subtree add --prefix="$mod" "$remote_name" "$branch" --squash \
                    -m "Add $mod config as git subtree"
            else
                warn "Subtree-Ordner '$mod' fehlt lokal und Remote '$remote_name' hat noch keinen '$branch'-Branch."
            fi
        fi
    done

    ok "Alle 5 Git-Subtrees (${SUBTREE_MODULES[*]}) und Remotes sind eingerichtet."
}

pull_one() {
    local mod="$1"
    local remote_name remote_url branch
    remote_name="$(get_remote_name "$mod")"
    remote_url="$(get_remote_url "$mod")"
    branch="$(get_branch "$mod")"

    ensure_remotes
    check_clean_worktree || return 1

    if ! remote_has_branch "$remote_name" "$branch"; then
        warn "Remote '$remote_name' ($remote_url) hat auf GitHub noch keinen '$branch'-Branch – überspringe Pull."
        warn "Tipp: Mit '~/git/dotfiles/scripts/update-subtrees.sh push $mod' initial ins Remote-Repo pushen."
        return 0
    fi

    info "Hole neueste Commits von $remote_name ($remote_url)..."
    git -C "$DOTFILES_DIR" fetch "$remote_name" "$branch"
    info "Aktualisiere Git-Subtree '$mod'..."
    git -C "$DOTFILES_DIR" subtree pull --prefix="$mod" "$remote_name" "$branch" --squash \
        -m "Update $mod subtree from upstream"
    ok "Subtree '$mod' erfolgreich aktualisiert."
}

push_one() {
    local mod="$1"
    local remote_name remote_url branch
    remote_name="$(get_remote_name "$mod")"
    remote_url="$(get_remote_url "$mod")"
    branch="$(get_branch "$mod")"

    ensure_remotes

    info "Pushe Subtree '$mod/' nach $remote_name ($remote_url -> $branch)..."
    git -C "$DOTFILES_DIR" subtree push --prefix="$mod" "$remote_name" "$branch"
    ok "Subtree '$mod' erfolgreich nach $remote_name/$branch gepusht."
}

push_subtree() {
    local target="${1:-all}"
    case "$target" in
        nvim|tmux|ghostty|kitty|vim)
            push_one "$target"
            ;;
        all)
            for mod in "${SUBTREE_MODULES[@]}"; do
                push_one "$mod"
            done
            ;;
        *)
            error "Unbekanntes Push-Ziel: $target (erlaubt: nvim, tmux, ghostty, kitty, vim, all)"
            exit 1
            ;;
    esac
}

show_status() {
    ensure_remotes
    printf "\n%-10s %-16s %-54s %-10s\n" "PFAD" "REMOTE" "GITHUB-URL" "UPSTREAM"
    printf "%-10s %-16s %-54s %-10s\n" "----------" "----------------" "------------------------------------------------------" "----------"
    for mod in "${SUBTREE_MODULES[@]}"; do
        local remote_name remote_url branch state
        remote_name="$(get_remote_name "$mod")"
        remote_url="$(get_remote_url "$mod")"
        branch="$(get_branch "$mod")"
        if remote_has_branch "$remote_name" "$branch"; then
            state="main aktiv"
        else
            state="leer (push bereit)"
        fi
        printf "%-10s %-16s %-54s %-10s\n" "$mod/" "$remote_name" "$remote_url" "$state"
    done
    echo ""
}

usage() {
    cat <<EOF
Verwendung: $(basename "$0") [BEFEHL]

Befehle:
  all                 Alle 5 Git-Subtrees (nvim, tmux, ghostty, kitty, vim) von Upstream pullen (Standard)
  nvim                Nur den nvim-Subtree (MichaelWeissDEV/nvim-config) pullen
  tmux                Nur den tmux-Subtree (MichaelWeissDEV/tmux-config) pullen
  ghostty             Nur den ghostty-Subtree (MichaelWeissDEV/ghostty-config) pullen
  kitty               Nur den kitty-Subtree (MichaelWeissDEV/kittiy-config) pullen
  vim                 Nur den vim-Subtree (MichaelWeissDEV/vim-config) pullen
  push [ziel]         Lokale Subtree-Commits nach Upstream pushen (nvim, tmux, ghostty, kitty, vim oder all)
  setup               Git-Remotes & Subtrees initial prüfen/einrichten
  status              Status-Übersicht aller 5 Subtrees & Remotes anzeigen
  help                Diese Hilfe anzeigen
EOF
}

main() {
    local cmd="${1:-all}"
    case "$cmd" in
        all|pull|update)
            for mod in "${SUBTREE_MODULES[@]}"; do
                pull_one "$mod"
            done
            ok "Alle Git-Subtrees (${SUBTREE_MODULES[*]}) wurden geprüft/aktualisiert!"
            ;;
        nvim|tmux|ghostty|kitty|vim)
            pull_one "$cmd"
            ;;
        push)
            push_subtree "${2:-all}"
            ;;
        setup|init)
            setup_subtrees
            ;;
        status|list)
            show_status
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
