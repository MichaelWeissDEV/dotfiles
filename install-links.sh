#!/usr/bin/env bash
# ============================================================================
# ~/git/dotfiles/install-links.sh - Symlinks für ~/.config & Home einrichten
# ============================================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$DOTFILES_DIR/install.sh" links "$@"
