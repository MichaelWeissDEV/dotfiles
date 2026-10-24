<div align="center">

# Foot Configuration — Catppuccin Mocha

**An ultra-lightweight, native Wayland terminal styled in Catppuccin Mocha.**

Arch Linux · Wayland · Foot · Catppuccin Mocha

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Terminals Docs](https://img.shields.io/badge/docs-Terminals%20Guide-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/terminals/#3-foot-configfootfootini)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Arch Linux](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) ·
[Installation Guide](https://arch-dotfiles.readthedocs.io/en/latest/installation/) ·
[Configuration (`foot.ini`)](foot.ini)

</div>

---

## Overview

This directory contains the **Foot** terminal emulator configuration for the **Arch Linux + Hyprland** dotfiles ecosystem (`arch-dotfiles`). Foot is an ultra-fast, minimal terminal designed specifically for Wayland compositors.

## Configuration Files

| File | Target Path | Description |
| :--- | :--- | :--- |
| **[`foot.ini`](foot.ini)** | `~/.config/foot/foot.ini` | Main configuration file (shell, font, opacity, palette) |

## Key Features

- **Catppuccin Mocha**: Complete 16-color pastel palette matching Ghostty and Kitty.
- **Uniform Transparency**: `alpha=0.90` opacity synchronized with Ghostty and Kitty.
- **Typography**: `JetBrainsMono Nerd Font` at `10.5pt` with `8x8` padding.
- **Shell**: Launches directly into `/usr/bin/zsh` with Oh My Zsh.
- **Ultra-low Memory**: Consumes only ~15 MB RAM, starting instantaneously.

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
