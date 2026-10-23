# kittiy-config

A clean, GPU-accelerated **Kitty** terminal configuration styled in the official **Catppuccin Mocha** palette with balanced transparency, JetBrainsMono Nerd Font typography, and Powerline tab styling.

:::{note}
**Part of the dotfiles ecosystem**: This is Michael Weiss' personal Kitty configuration. It is created to provide instant rendering, zero audio bells, and a distraction-free terminal workflow for anyone using Arch Linux, macOS, or another modern desktop.
:::

---

## Highlights

- 🎨 **Catppuccin Mocha Palette**: Complete 16-color pastel palette (`#1e1e2e` base, `#cdd6f4` text, `#89b4fa` pastel blue, `#f5e0dc` rosewater cursor).
- 🪟 **0.90 Opacity**: `background_opacity 0.90` and `dynamic_background_opacity yes` for transparent compositing on Wayland/X11.
- 🔖 **Powerline Tabs**: Beautiful `powerline` styled tabs with active tab highlighting in Pastel Blue.
- ⚡ **Instant Response**: `enable_audio_bell no`, `confirm_os_window_close 0`, and starts directly into `/usr/bin/zsh`.
- 🔤 **JetBrainsMono Nerd Font**: Sized at `10.5pt` with `8px` padding.

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

Dotfiles (main hub) <https://michaelweiss-dotfiles.readthedocs.io/en/latest/>
Neovim (nvim-config) <https://nvim-config.readthedocs.io/en/latest/>
tmux (tmux-config) <https://tmux-config.readthedocs.io/en/latest/>
Ghostty (ghostty-config) <https://ghostty-config.readthedocs.io/en/latest/>
Vim (vim-config) <https://vim-config.readthedocs.io/en/latest/>
```

---

## Quick Start

### Standalone Installation

```bash
git clone https://github.com/MichaelWeissDEV/kittiy-config.git ~/.config/kitty
kitty
```

### In the Dotfiles Repository

This repository is integrated as a **Git-Subtree** at `kitty/` in `~/git/dotfiles` and linked directly to `~/.config/kitty`:

```bash
# Update subtree from upstream:
~/git/dotfiles/scripts/update-subtrees.sh kitty

# Push local changes back to upstream:
~/git/dotfiles/scripts/update-subtrees.sh push kitty
```

---

## Connected Dotfiles Ecosystem

- **[Dotfiles Hub](https://michaelweiss-dotfiles.readthedocs.io/en/latest/)**: Central repository uniting desktop, window manager, and shell environments.
- **[ghostty-config](https://ghostty-config.readthedocs.io/en/latest/)**: Alternative GPU terminal sharing identical opacity and styling.
- **[nvim-config](https://nvim-config.readthedocs.io/en/latest/)**: Fast Neovim configuration with matching Catppuccin themes.
- **[tmux-config](https://tmux-config.readthedocs.io/en/latest/)**: Terminal multiplexer configured for seamless terminal integration.
- **[vim-config](https://vim-config.readthedocs.io/en/latest/)**: Standalone Vim configuration.
