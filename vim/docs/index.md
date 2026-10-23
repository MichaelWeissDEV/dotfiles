# vim-config

A lightweight, zero-plugin **Vim** configuration crafted in the official **Catppuccin Mocha** palette. Built with native Vimscript for sub-10ms startup times, pure XDG file hygiene, dynamic statusline telemetry, and keybindings synchronized with Neovim.

:::{note}
**Part of the dotfiles ecosystem**: This is Michael Weiss' personal Vim configuration. Engineered as a robust, dependency-free editor setup, it runs reliably on minimal servers, SSH containers, and modern desktop systems alike. Beginners can install it with a single command without worrying about package managers or plugin compilers.
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

Dotfiles (main hub) <https://michaelweiss-dotfiles.readthedocs.io/en/latest/>
Neovim (nvim-config) <https://nvim-config.readthedocs.io/en/latest/>
tmux (tmux-config) <https://tmux-config.readthedocs.io/en/latest/>
Ghostty (ghostty-config) <https://ghostty-config.readthedocs.io/en/latest/>
Kitty (kittiy-config) <https://kittiy-config.readthedocs.io/en/latest/>
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

### In the Dotfiles Repository

This repository is maintained as a **Git-Subtree** at `vim/` inside `~/git/dotfiles`:

```bash
# Update subtree from upstream:
~/git/dotfiles/scripts/update-subtrees.sh vim

# Push local changes back to upstream:
~/git/dotfiles/scripts/update-subtrees.sh push vim
```

---

## Connected Dotfiles Ecosystem

- **[Dotfiles Hub](https://michaelweiss-dotfiles.readthedocs.io/en/latest/)**: Central repository uniting desktop, window manager, and shell environments.
- **[nvim-config](https://nvim-config.readthedocs.io/en/latest/)**: Full-featured IDE configuration powered by Lua, LSP, Treesitter, and Snacks.nvim.
- **[tmux-config](https://tmux-config.readthedocs.io/en/latest/)**: Terminal multiplexer sharing identical navigation semantics.
- **[ghostty-config](https://ghostty-config.readthedocs.io/en/latest/)**: High-performance GPU terminal with matching Catppuccin theme.
- **[kittiy-config](https://kittiy-config.readthedocs.io/en/latest/)**: GPU terminal with Powerline tabs and transparency.
