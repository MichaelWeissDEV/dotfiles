# kitty-config

[![Docs](https://readthedocs.org/projects/kitty-config/badge/?version=latest)](https://kitty-config.readthedocs.io/en/latest/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Linux | macOS](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Linux%20%7C%20macOS-89b4fa)](https://sw.kovidgoyal.net/kitty/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/MichaelWeissDEV/kitty-config/blob/main/LICENSE)

A clean, GPU-accelerated **Kitty** terminal configuration styled in the official **Catppuccin Mocha** palette with balanced transparency, JetBrainsMonoNL Nerd Font typography (no ligatures), and Powerline tab styling.

:::{note}
**Part of the Arch Dotfiles Ecosystem**: Built for **Arch Linux** as part of [`arch-dotfiles`](https://arch-dotfiles.readthedocs.io/en/latest/), this Kitty configuration provides instant rendering, zero audio bells, and a distraction-free terminal workflow that anyone can install on Arch Linux or adapt to **any Linux distribution or macOS**.
:::

---

## Highlights

- 🎨 **Catppuccin Mocha Palette**: Complete 16-color pastel palette (`#1e1e2e` base, `#cdd6f4` text, `#89b4fa` pastel blue, `#f5e0dc` rosewater cursor).
- 🪟 **0.90 Opacity**: `background_opacity 0.90` and `dynamic_background_opacity yes` for transparent compositing on Wayland/X11.
- 🔖 **Powerline Tabs**: Beautiful `powerline` styled tabs with active tab highlighting in Pastel Blue.
- ⚡ **Instant Response**: `enable_audio_bell no`, `confirm_os_window_close 0`, and starts directly into `/usr/bin/zsh`.
- 🔤 **JetBrainsMonoNL Nerd Font**: Sized at `10.5pt` (No Ligatures variant) with `8px` padding.

---

## Table of Contents

```{toctree}
:maxdepth: 2
:caption: User Guide

installation
configuration
keybindings
faq
```

```{toctree}
:caption: Related documentation
:hidden:

Arch Dotfiles (main hub) <https://arch-dotfiles.readthedocs.io/en/latest/>
Neovim (nvim-config) <https://nvim-config.readthedocs.io/en/latest/>
tmux (tmux-config) <https://tmux-config.readthedocs.io/en/latest/>
Ghostty (ghostty-config) <https://ghostty-config.readthedocs.io/en/latest/>
Vim (vim-config) <https://vim-config.readthedocs.io/en/latest/>
```

---

## Quick Start

### Standalone Installation

```bash
git clone https://github.com/MichaelWeissDEV/kitty-config.git ~/.config/kitty
kitty
```

### In the Arch Dotfiles Repository

This repository is integrated as a **Git Subtree** at `kitty/` in `~/git/dotfiles` and linked directly to `~/.config/kitty`:

```bash
# Update everything (system, dotfiles & all subtrees):
adot update
# (also available as: arch-dot update / arch-dotfiles update)

# Update only the kitty subtree from upstream:
adot update kitty

# Inspect status or terminal keybindings:
adot status
adot keys terminals

# Push local changes back to upstream:
adot push kitty
```

---

## Connected Dotfiles Ecosystem

- **[Arch Dotfiles Hub (`arch-dotfiles`)](https://arch-dotfiles.readthedocs.io/en/latest/)**: Central repository uniting the Arch Linux + Hyprland desktop, window manager, and shell environments.
- **[ghostty-config](https://ghostty-config.readthedocs.io/en/latest/)**: Alternative GPU terminal sharing identical opacity and styling.
- **[nvim-config](https://nvim-config.readthedocs.io/en/latest/)**: Reproducible, offline-capable Neovim IDE with matching Catppuccin themes.
- **[tmux-config](https://tmux-config.readthedocs.io/en/latest/)**: Portable terminal multiplexer configured for seamless terminal integration.
- **[vim-config](https://vim-config.readthedocs.io/en/latest/)**: Zero-plugin standalone Vim configuration.
