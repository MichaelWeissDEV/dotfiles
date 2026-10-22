#!/usr/bin/env bash
# ============================================================================
# ~/git/dotfiles/scripts/install-links.sh - Symlinks für ~/.config & ~ setzen
# ============================================================================
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPTS_DIR/install.sh" links "$@"
