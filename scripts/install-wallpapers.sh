#!/usr/bin/env bash
# ============================================================================
# ~/git/dotfiles/scripts/install-wallpapers.sh
# Privates Wallpaper-Repository in ~/git/dotfiles/pictures einrichten
# ============================================================================
# Das Verzeichnis pictures/ ist im Dotfiles-Repo per .gitignore ausgeschlossen
# und wird nicht mit dem öffentlichen Dotfiles-Repo veröffentlicht
# (Urheberrecht). Es wird separat als privates Git-Repository geklont.
#
# Verwendung:
#   ./scripts/install-wallpapers.sh <git-url>
#   WALLPAPER_REPO_URL=<git-url> ./scripts/install-wallpapers.sh
#   ./scripts/install-wallpapers.sh --update
# ============================================================================
set -euo pipefail

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPTS_DIR="$(dirname "$SCRIPT_PATH")"
DOTFILES_DIR="$(dirname "$SCRIPTS_DIR")"
TARGET="$DOTFILES_DIR/pictures"

info()  { printf "\033[1;34m[INFO]\033[0m  %s\n" "$*"; }
ok()    { printf "\033[1;32m[OK]\033[0m    %s\n" "$*"; }
error() { printf "\033[1;31m[ERROR]\033[0m %s\n" "$*" >&2; }
die()   { error "$*"; exit 1; }

usage() {
    cat <<EOF
Verwendung: $(basename "$0") <git-url>
       oder: $(basename "$0") --update
       oder: WALLPAPER_REPO_URL=<git-url> $(basename "$0")

Klont oder aktualisiert das private Wallpaper-Repository unter:
  $TARGET

Das Verzeichnis ist per .gitignore aus dem öffentlichen Dotfiles-Repo
ausgeschlossen (Urheberrecht).
EOF
}

case "${1:-}" in
    -h|--help|help)
        usage
        exit 0
        ;;
    --update)
        [[ -d "$TARGET/.git" ]] || die "Kein privates Wallpaper-Repo unter $TARGET gefunden."
        info "Aktualisiere $TARGET ..."
        git -C "$TARGET" pull --ff-only
        ok "Wallpaper-Repo aktualisiert."
        exit 0
        ;;
esac

if [[ -d "$TARGET/.git" ]]; then
    info "Wallpaper-Repo existiert bereits: $TARGET"
    info "Aktualisieren mit: $0 --update"
    exit 0
fi

url="${1:-${WALLPAPER_REPO_URL:-}}"
[[ -n "$url" ]] || { usage; die "Bitte die Git-URL des privaten Wallpaper-Repos angeben."; }

if [[ -d "$TARGET" && -n "$(ls -A "$TARGET" 2>/dev/null || true)" ]]; then
    die "$TARGET ist nicht leer. Bitte vor dem Klonen leeren (oder Bilder sichern)."
fi

mkdir -p "$TARGET"
info "Klonen nach $TARGET ..."
git clone "$url" "$TARGET"
ok "Privates Wallpaper-Repo eingerichtet: $TARGET"
info "Wallpaper anzeigen: wallpaper list"
