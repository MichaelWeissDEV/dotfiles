<div align="center">

# Zsh Configuration — Catppuccin Mocha

**A clean, fast Zsh setup with Oh My Zsh, autosuggestions, zoxide jump (`j`), and FZF.**

Arch Linux · Zsh · Oh My Zsh · Catppuccin Mocha

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Shell Docs](https://img.shields.io/badge/docs-Shell%20%26%20CLI-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/shell/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Shell: Zsh](https://img.shields.io/badge/shell-Zsh%20%7C%20Oh%20My%20Zsh-blue?logo=gnu-bash&logoColor=white)](https://zsh.sourceforge.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Shell & CLI Guide](https://arch-dotfiles.readthedocs.io/en/latest/shell/) ·
[Installation Guide](https://arch-dotfiles.readthedocs.io/en/latest/installation/) ·
[Startup (`zshrc`)](zshrc) ·
[Aliases (`aliases.zsh`)](aliases.zsh)

</div>

---

## Overview

This directory contains the **Zsh** shell configuration for the **Arch Linux Dotfiles** ecosystem (`arch-dotfiles`). It pairs Oh My Zsh with a distraction-free pastel prompt, asynchronous history autosuggestions, syntax highlighting, smart directory jumping (`j` / `ji` via `zoxide`), and fast productivity aliases.

## Configuration Files

| File | Target Symlink | Description |
| :--- | :--- | :--- |
| **[`zshrc`](zshrc)** | `~/.zshrc` | Primary Zsh startup configuration, OMZ plugin loading, environment variables |
| **[`aliases.zsh`](aliases.zsh)** | `~/.config/zsh/aliases.zsh` | Aliases for `adot`, `yazi` (`y`), `nvim` (`nv`), `vim` (`v`), `tmux` (`tm`), `fzf` |
| **[`themes/catppuccin.zsh-theme`](themes/catppuccin.zsh-theme)** | `~/.oh-my-zsh/custom/themes/...` | Minimal Catppuccin Mocha prompt theme (`> `) |

## Key Features

- **Smart Directory Jump (`j`)**: Jump to frequent directories via `j <query>` or interactive `fzf` selector via `ji` (powered by `zoxide`).
- **Autosuggestions & Syntax Highlighting**: Type ahead with historical suggestions (<kbd>→</kbd> or <kbd>End</kbd> to accept) and live command validation.
- **Sudo Shortcut**: Press <kbd>Esc</kbd> <kbd>Esc</kbd> to prefix current or last command with `sudo`.
- **Yazi Shell Wrapper (`y`)**: Quitting Yazi (<kbd>q</kbd>) automatically changes the shell's working directory to the last browsed folder.
- **Ecosystem CLI (`adot`)**: Full CLI command integration (`adot update`, `adot status`, `adot list`, `adot keys`, `adot commands`).

---

## Connected Dotfiles Ecosystem

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** *(Main System)* | [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [`MichaelWeissDEV/nvim-config`](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [`MichaelWeissDEV/tmux-config`](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Ghostty (`ghostty-config`)** | [`MichaelWeissDEV/ghostty-config`](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [`MichaelWeissDEV/kittiy-config`](https://github.com/MichaelWeissDEV/kittiy-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Vim (`vim-config`)** | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
