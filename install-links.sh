#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sfn "$CONFIG_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sfn "$CONFIG_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

if [[ -d "$HOME/.oh-my-zsh/custom/themes" ]]; then
    ln -sfn "$CONFIG_DIR/zsh/themes/catppuccin.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/catppuccin.zsh-theme"
fi

echo "Symlinks erfolgreich eingerichtet (.zshrc, .tmux.conf)."
