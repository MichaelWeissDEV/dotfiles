#!/usr/bin/env bash
# ============================================================================
# ~/git/dotfiles/scripts/install.sh - Bootstrap wrapper for 'adot'
# Running './scripts/install.sh' with no arguments runs 'adot install'.
# All other arguments are forwarded directly to '~/git/dotfiles/scripts/adot'.
# ============================================================================
set -euo pipefail

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPTS_DIR="$(dirname "$SCRIPT_PATH")"

if [[ $# -eq 0 ]]; then
    exec "$SCRIPTS_DIR/adot" install
else
    exec "$SCRIPTS_DIR/adot" "$@"
fi
