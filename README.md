<div align="center">

# ghostty-config

**A minimalist, high-performance Ghostty terminal configuration in Catppuccin Mocha.**

Arch Linux · Linux · macOS · Hyprland · Zsh · tmux · Neovim

[![Docs](https://readthedocs.org/projects/ghostty-config/badge/?version=latest)](https://ghostty-config.readthedocs.io/en/latest/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Linux | macOS](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Linux%20%7C%20macOS-89b4fa)](https://ghostty.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[**Documentation**](https://ghostty-config.readthedocs.io/en/latest/) ·
[Installation](https://ghostty-config.readthedocs.io/en/latest/installation/) ·
[Configuration Guide](https://ghostty-config.readthedocs.io/en/latest/configuration/) ·
[Configuration File (`config`)](config) ·
[Keybindings](https://ghostty-config.readthedocs.io/en/latest/keybindings/) ·
[FAQ](https://ghostty-config.readthedocs.io/en/latest/faq/) ·
[Arch Dotfiles Hub](https://arch-dotfiles.readthedocs.io/en/latest/)

</div>

---

## Overview

A clean, distraction-free **Ghostty** configuration ([`config`](config)) styled in the official **Catppuccin Mocha (Pastel Theme)** palette. Built primarily for **Arch Linux** (with Hyprland, Zsh, tmux, and Neovim), it is completely self-contained and works out-of-the-box on **any Linux distribution or macOS** with minimal or zero adjustments.

## Features

- **Official Catppuccin Mocha Palette**: Base `#1e1e2e`, Text `#cdd6f4`, Pastel Blue selection `#89b4fa`, and solid Rosewater block cursor `#f5e0dc`.
- **Uniform Transparency**: Subtle background transparency (`background-opacity = 0.90`), matched identically with sibling `kitty` and `foot` terminals.
- **Typography**: `JetBrainsMono Nerd Font` (`10.5pt`) with complete Nerd Font and Powerline glyph coverage.
- **Minimalist Window Layout**:
  - No titlebar or window decorations (`window-decoration = none`, `gtk-titlebar = false`) for maximum screen real estate in tiling compositors.
  - Balanced `8px` horizontal and vertical padding (`window-padding-balance = true`).
  - Launches directly into `/usr/bin/zsh` (adjust to `/bin/zsh` or `fish`/`bash` on non-Arch systems if needed).
  - Closes immediately without confirmation popups (`confirm-close-surface = false`).

---

## Keybindings & Shortcuts

Full reference: [Ghostty Keybindings Documentation](https://ghostty-config.readthedocs.io/en/latest/keybindings/).

| Shortcut | Action |
| :--- | :--- |
| `Ctrl + Shift + C` *(or `Cmd + C` on macOS)* | Copy selection to system clipboard |
| `Ctrl + Shift + V` *(or `Cmd + V` on macOS)* | Paste from system clipboard |
| `Ctrl + =` / `Ctrl + -` / `Ctrl + 0` | Increase / decrease / reset font size (`10.5pt`) |
| `Ctrl + Shift + D` / `Ctrl + Shift + R` | Split pane horizontally (down) / vertically (right) |
| `Ctrl + Shift + T` / `Ctrl + Shift + W` | New tab / Close active surface or tab |
| `Ctrl + Shift + ,` *(or `Cmd + ,` on macOS)* | Live-reload `~/.config/ghostty/config` ([`config`](config)) |
| `F11` | Toggle fullscreen |

---

## Installation

### 1. Standalone (`~/.config/ghostty`)

 Works on Arch Linux, Debian/Ubuntu, Fedora, macOS, and any other system running Ghostty:

```bash
git clone https://github.com/MichaelWeissDEV/ghostty-config.git ~/.config/ghostty
```

### 2. Inside the Arch Linux Dotfiles Ecosystem (`~/git/dotfiles`)

This repository is embedded as a **Git Subtree** under `ghostty/` in [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) and symlinked to `~/.config/ghostty`.

```bash
# Update EVERYTHING (system, dotfiles & all subtrees) via the central CLI:
adot update
# (also available as: arch-dot update / arch-dotfiles update)

# Pull only the ghostty subtree from upstream:
adot update ghostty

# Inspect live status & keybindings:
adot status
adot keys terminals

# Push local commits from ~/git/dotfiles/ghostty back to upstream:
adot push ghostty
```

<details>
<summary><b>Manual <code>git subtree</code> commands</b></summary>

```bash
# Add remote (one-time):
git remote add ghostty-remote https://github.com/MichaelWeissDEV/ghostty-config.git

# Pull updates from upstream:
git fetch ghostty-remote main
git subtree pull --prefix=ghostty ghostty-remote main --squash -m "Update ghostty subtree from upstream"

# Push local changes to upstream:
git subtree push --prefix=ghostty ghostty-remote main
```

</details>

---

## Connected Dotfiles Ecosystem

This configuration is part of a unified development environment. Explore the full ecosystem documentation:

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** *(Main System)* | [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [`MichaelWeissDEV/nvim-config`](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [`MichaelWeissDEV/tmux-config`](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Ghostty (`ghostty-config`)** | [`MichaelWeissDEV/ghostty-config`](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [`MichaelWeissDEV/kittiy-config`](https://github.com/MichaelWeissDEV/kittiy-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Vim (`vim-config`)** | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
