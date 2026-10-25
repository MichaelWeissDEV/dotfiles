<div align="center">

# Yazi File Manager Configuration — Catppuccin Mocha

**High-performance terminal file manager styled in Catppuccin Mocha with shell directory sync.**

Arch Linux · Yazi · TUI · Catppuccin Mocha

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Shell Docs](https://img.shields.io/badge/docs-Shell%20%26%20CLI-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/shell/#yazi-directory-tracking-wrapper-y)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Yazi](https://img.shields.io/badge/app-Yazi%20TUI-89b4fa)](https://yazi-rs.github.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Shell & CLI Guide](https://arch-dotfiles.readthedocs.io/en/latest/shell/) ·
[Installation Guide](https://arch-dotfiles.readthedocs.io/en/latest/installation/) ·
[Configuration (`yazi.toml`)](yazi.toml) ·
[Theme (`theme.toml`)](theme.toml)

</div>

---

## Overview

This directory contains the **Yazi** terminal file manager configuration for the **Arch Linux Dotfiles** ecosystem (`arch-dotfiles`), customized with the official `catppuccin-mocha.yazi` flavor and automatic working-directory tracking via the `y` shell function.

## Configuration Files

| File | Target Path | Description |
| :--- | :--- | :--- |
| **[`yazi.toml`](yazi.toml)** | `~/.config/yazi/yazi.toml` | Layout ratios `[1, 3, 4]`, natural sorting, hidden files, mouse events |
| **[`theme.toml`](theme.toml)** | `~/.config/yazi/theme.toml` | Flavor selector referencing `catppuccin-mocha` |
| **[`package.toml`](package.toml)** | `~/.config/yazi/package.toml` | Package manifest tracking the Catppuccin Mocha flavor |
| **[`flavors/catppuccin-mocha.yazi/`](flavors/catppuccin-mocha.yazi/)** | `~/.config/yazi/flavors/...` | Official Catppuccin Mocha pastel palette for Yazi |

## Key Features

- **Shell Directory Synchronization (`y`)**: Running `y` opens Yazi. Quitting with <kbd>q</kbd> immediately `cd`s your active shell into the last browsed directory.
- **Async & Fast**: Built in Rust with async I/O and GPU image previews.
- **Natural Column Ratio**: 1:3:4 column proportions for clear parent, current, and preview visibility.

---

## Connected Dotfiles Ecosystem

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** *(Main System)* | [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [`MichaelWeissDEV/nvim-config`](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [`MichaelWeissDEV/tmux-config`](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Ghostty (`ghostty-config`)** | [`MichaelWeissDEV/ghostty-config`](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [`MichaelWeissDEV/kitty-config`](https://github.com/MichaelWeissDEV/kitty-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Foot (`foot-config`)** | [`MichaelWeissDEV/foot-config`](https://github.com/MichaelWeissDEV/foot-config) | [Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) |
| **Vim (`vim-config`)** | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
