<div align="center">

# kitty-config

**A fast, GPU-accelerated Kitty terminal configuration in Catppuccin Mocha.**

Arch Linux · Linux · macOS · Hyprland · Zsh · tmux · Neovim

[![Docs](https://readthedocs.org/projects/kitty-config/badge/?version=latest)](https://kitty-config.readthedocs.io/en/latest/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Linux | macOS](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Linux%20%7C%20macOS-89b4fa)](https://sw.kovidgoyal.net/kitty/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[**Documentation**](https://kitty-config.readthedocs.io/en/latest/) ·
[Installation](https://kitty-config.readthedocs.io/en/latest/installation/) ·
[Configuration Guide](https://kitty-config.readthedocs.io/en/latest/configuration/) ·
[Configuration File (`kitty.conf`)](kitty.conf) ·
[Keybindings](https://kitty-config.readthedocs.io/en/latest/keybindings/) ·
[FAQ](https://kitty-config.readthedocs.io/en/latest/faq/) ·
[Arch Dotfiles Hub](https://arch-dotfiles.readthedocs.io/en/latest/)

</div>

---

## Overview

A minimalist, GPU-accelerated **Kitty** configuration ([`kitty.conf`](kitty.conf)) styled in the official **Catppuccin Mocha (Pastel Theme)** color scheme. Designed as the primary terminal for the **Arch Linux + Hyprland** dotfiles ecosystem, it can be installed standalone on **any Arch Linux machine** or easily adapted to **other Linux distributions and macOS**.

## Features

- **Official Catppuccin Mocha Palette**: Base `#1e1e2e`, Text `#cdd6f4`, Pastel Blue selection `#89b4fa`, solid Rosewater block cursor `#f5e0dc`, and Powerline-styled tabs.
- **Uniform Transparency**: Subtle background transparency (`background_opacity 0.90`, `dynamic_background_opacity yes`), synchronized with `ghostty` and `foot`.
- **Typography**: `JetBrainsMono Nerd Font` (`10.5pt`) with automatic bold/italic font selection.
- **Minimalist & Responsive Behavior**:
  - Starts directly with `/usr/bin/zsh` (easily changed if your shell path differs on another OS).
  - Clean `8px` window padding (`window_padding_width 8`).
  - Zero audio bell distraction (`enable_audio_bell no`).
  - Closes immediately without confirmation prompts (`confirm_os_window_close 0`).

---

## Keybindings & Shortcuts

Full reference: [Kitty Keybindings Documentation](https://kitty-config.readthedocs.io/en/latest/keybindings/).

| Shortcut | Action |
| :--- | :--- |
| `Ctrl + Shift + C` / `Ctrl + Shift + V` | Copy to clipboard / Paste from clipboard |
| `Ctrl + Shift + T` / `Ctrl + Shift + Q` | Open new tab / Close active tab |
| `Ctrl + Shift + Right` / `Left` | Cycle to next / previous tab |
| `Ctrl + Shift + Enter` / `Ctrl + Shift + W` | Open new split window / Close active window |
| `Ctrl + Shift + =` / `-` / `Backspace` | Increase / decrease / reset font size (`10.5pt`) |
| `Ctrl + Shift + H` | Browse scrollback buffer in pager |
| `Ctrl + Shift + F5` | Live-reload `~/.config/kitty/kitty.conf` ([`kitty.conf`](kitty.conf)) |

---

## Installation

### 1. Standalone (`~/.config/kitty`)

Works out-of-the-box on Arch Linux, Debian/Ubuntu, Fedora, macOS, and other Unix-like systems:

```bash
git clone https://github.com/MichaelWeissDEV/kittiy-config.git ~/.config/kitty
```

### 2. Inside the Arch Linux Dotfiles Ecosystem (`~/git/dotfiles`)

This repository is embedded as a **Git Subtree** under `kitty/` in [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) and symlinked to `~/.config/kitty`.

```bash
# Update EVERYTHING (system, dotfiles & all subtrees) via the central CLI:
adot update
# (also available as: arch-dot update / arch-dotfiles update)

# Pull only the kitty subtree from upstream:
adot update kitty

# Inspect live status & terminal keybindings:
adot status
adot keys terminals

# Push local commits from ~/git/dotfiles/kitty back to upstream:
adot push kitty
```

<details>
<summary><b>Manual <code>git subtree</code> commands</b></summary>

```bash
# Add remote (one-time):
git remote add kitty-remote https://github.com/MichaelWeissDEV/kittiy-config.git

# Pull updates from upstream:
git fetch kitty-remote main
git subtree pull --prefix=kitty kitty-remote main --squash -m "Update kitty subtree from upstream"

# Push local changes to upstream:
git subtree push --prefix=kitty kitty-remote main
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
