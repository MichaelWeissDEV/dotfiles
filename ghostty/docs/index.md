# ghostty-config

[![Docs](https://readthedocs.org/projects/ghostty-config/badge/?version=latest)](https://ghostty-config.readthedocs.io/en/latest/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Linux | macOS](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Linux%20%7C%20macOS-89b4fa)](https://ghostty.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/MichaelWeissDEV/ghostty-config/blob/main/LICENSE)

A minimalist, high-performance **Ghostty** terminal configuration styled in the official **Catppuccin Mocha** palette with tasteful transparency, custom font metrics, and seamless integration with Neovim, tmux, and Hyprland.

:::{note}
**Part of the Arch Dotfiles Ecosystem**: Built for **Arch Linux** as part of [`arch-dotfiles`](https://arch-dotfiles.readthedocs.io/en/latest/), this Ghostty configuration is completely self-contained and beginner-friendly so anyone can install it on Arch Linux or use it standalone on **any Linux distribution or macOS** with minimal adjustments.
:::

---

## Highlights

- 🎨 **Official Catppuccin Mocha Theme**: Base `#1e1e2e`, foreground `#cdd6f4`, selection `#89b4fa`, and block cursor in Rosewater `#f5e0dc`.
- 🪟 **Subtle Transparency**: Balanced `0.90` background opacity matching sibling Kitty and Foot configurations.
- 🔤 **JetBrainsMonoNL Nerd Font**: Sized at `10.5pt` (No Ligatures variant) with balanced padding (`8px` horizontal and vertical).
- ⚡ **Zero Bloat**: No window decorations or bulky titlebars (`window-decoration = none`, `gtk-titlebar = false`), starts directly with Zsh.
- 🔄 **Ecosystem Consistency**: Configured to work seamlessly with Neovim splits, tmux pane switching, and Hyprland tiling.

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
Kitty (kitty-config) <https://kitty-config.readthedocs.io/en/latest/>
Vim (vim-config) <https://vim-config.readthedocs.io/en/latest/>
```

---

## Quick Start

### Standalone Installation

```bash
git clone https://github.com/MichaelWeissDEV/ghostty-config.git ~/.config/ghostty
ghostty
```

### In the Arch Dotfiles Repository

This repository is integrated as a **Git Subtree** at `ghostty/` in `~/git/dotfiles` and linked directly to `~/.config/ghostty`:

```bash
# Update everything (system, dotfiles & all subtrees):
adot update
# (also available as: arch-dot update / arch-dotfiles update)

# Update only the ghostty subtree from upstream:
adot update ghostty

# Inspect status or terminal keybindings:
adot status
adot keys terminals

# Push local changes back to upstream:
adot push ghostty
```

---

## Connected Dotfiles Ecosystem

- **[Arch Dotfiles Hub (`arch-dotfiles`)](https://arch-dotfiles.readthedocs.io/en/latest/)**: Central repository uniting the Arch Linux + Hyprland desktop, window manager, and shell environments.
- **[nvim-config](https://nvim-config.readthedocs.io/en/latest/)**: Reproducible, offline-capable Neovim IDE with identical Catppuccin Mocha colors.
- **[tmux-config](https://tmux-config.readthedocs.io/en/latest/)**: Portable terminal multiplexer with truecolor and OSC 52 clipboard support.
- **[kitty-config](https://kitty-config.readthedocs.io/en/latest/)**: Alternative GPU-accelerated terminal with identical styling and Powerline tabs.
- **[vim-config](https://vim-config.readthedocs.io/en/latest/)**: Zero-plugin standalone Vim configuration.
