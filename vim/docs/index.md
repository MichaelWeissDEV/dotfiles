# vim-config

A lightweight, zero-plugin **Vim** configuration crafted in the official **Catppuccin Mocha** palette. Built with native Vimscript for sub-10ms startup times, pure XDG file hygiene, dynamic statusline telemetry, and keybindings synchronized with Neovim.

:::{note}
**Part of the Arch Dotfiles Ecosystem**: Built for **Arch Linux** as part of [`arch-dotfiles`](https://arch-dotfiles.readthedocs.io/en/latest/), this Vim configuration is engineered as a robust, dependency-free editor setup that runs out-of-the-box on any Arch Linux system, minimal SSH servers, containers, other Linux distributions, or macOS without package managers or plugin compilers.
:::

---

## Key Highlights

- ⚡ **Zero External Plugins**: 100% self-contained native Vimscript. No `vim-plug`, no `pathogen`, and no network dependencies needed during editor startup.
- 🎨 **Native Catppuccin Mocha**: Complete 16-color pastel theme defined natively in GUI colors (`#1e1e2e` base, `#89b4fa` pastel blue, `#cba6f7` mauve, `#a6e3a1` green).
- 📊 **Dynamic Statusline**: Custom modular statusline displaying live mode colors (`NORMAL`, `INSERT`, `VISUAL`, `REPLACE`), line number state (`NUM:REL`, `NUM:ABS`, `NUM:OFF`), file encoding, and cursor telemetry.
- 🔢 **Hybrid Line Number Toggling**: Instant switching between relative (hybrid) and absolute line numbers via `<Space>un`, `<Space>rn`, `<Space>n`, or `<F3>`. Complete toggle with `<Space>uN`.
- 🧹 **XDG Directory Compliance**: No `.swp` clutter in project trees. Persistent undo history is neatly stored in `~/.local/state/vim/undo/` and session data in `~/.local/state/vim/viminfo`.
- 🔄 **Neovim Harmony**: Shares identical `<Space>` Leader key, split navigation (`Ctrl+h/j/k/l`), and buffer management (`Shift+H`, `Shift+L`) with `nvim-config`.

---

## Table of Contents

```{toctree}
:maxdepth: 2
:caption: User Guide

installation
configuration
keybindings
statusline
faq
```

```{toctree}
:caption: Related documentation
:hidden:

Arch Dotfiles (main hub) <https://arch-dotfiles.readthedocs.io/en/latest/>
Neovim (nvim-config) <https://nvim-config.readthedocs.io/en/latest/>
tmux (tmux-config) <https://tmux-config.readthedocs.io/en/latest/>
Ghostty (ghostty-config) <https://ghostty-config.readthedocs.io/en/latest/>
Kitty (kitty-config) <https://kitty-config.readthedocs.io/en/latest/>
```

---

## Quick Start

### Standalone Installation

```bash
# Clone repository to ~/.config/vim
git clone https://github.com/MichaelWeissDEV/vim-config.git ~/.config/vim

# Symlink to ~/.vimrc and ensure undo directory exists
ln -sfn ~/.config/vim/vimrc ~/.vimrc
mkdir -p ~/.local/state/vim/undo
```

### In the Arch Dotfiles Repository

This repository is maintained as a **Git Subtree** at `vim/` inside `~/git/dotfiles`:

```bash
# Update everything (system, dotfiles & all subtrees):
adot update
# (also available as: arch-dot update / arch-dotfiles update)

# Update only the vim subtree from upstream:
adot update vim

# Inspect status or Vim keybindings:
adot status
adot keys vim

# Push local changes back to upstream:
adot push vim
```

---

## Connected Dotfiles Ecosystem

- **[Arch Dotfiles Hub (`arch-dotfiles`)](https://arch-dotfiles.readthedocs.io/en/latest/)**: Central repository uniting the Arch Linux + Hyprland desktop, window manager, and shell environments.
- **[nvim-config](https://nvim-config.readthedocs.io/en/latest/)**: Reproducible, offline-capable Neovim IDE powered by native Lua, LSP, and Tree-sitter.
- **[tmux-config](https://tmux-config.readthedocs.io/en/latest/)**: Terminal multiplexer sharing identical navigation semantics.
- **[ghostty-config](https://ghostty-config.readthedocs.io/en/latest/)**: High-performance GPU terminal with matching Catppuccin theme.
- **[kitty-config](https://kitty-config.readthedocs.io/en/latest/)**: GPU terminal with Powerline tabs and transparency.
