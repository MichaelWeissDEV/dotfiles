<div align="center">

# vim-config

**A zero-plugin, ultra-fast standalone Vim configuration in Catppuccin Mocha.**

100% Native Vimscript · Sub-10ms Startup · XDG-Clean · Synchronized with Neovim

[![Docs](https://readthedocs.org/projects/vim-config/badge/?version=latest)](https://vim-config.readthedocs.io/en/latest/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Vim 8.2+ / 9.0+](https://img.shields.io/badge/Vim-8.2%2B%20%7C%209.0%2B-019733?logo=vim&logoColor=white)](https://www.vim.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[**Documentation**](https://vim-config.readthedocs.io/en/latest/) ·
[Installation](https://vim-config.readthedocs.io/en/latest/installation/) ·
[Configuration Guide](https://vim-config.readthedocs.io/en/latest/configuration/) ·
[Configuration File (`vimrc`)](vimrc) ·
[Keybindings & Commands](https://vim-config.readthedocs.io/en/latest/keybindings/) ·
[Statusline](https://vim-config.readthedocs.io/en/latest/statusline/) ·
[Arch Dotfiles Hub](https://arch-dotfiles.readthedocs.io/en/latest/)

</div>

---

## Overview

A standalone, zero-dependency **Vim** configuration ([`vimrc`](vimrc)) crafted in the official **Catppuccin Mocha (Pastel Theme)** design and synchronized with the core options and keybindings of [`nvim-config`](https://nvim-config.readthedocs.io/en/latest/).

Because it relies purely on native Vimscript with zero external plugins, it runs out-of-the-box on **any Arch Linux system**, **other Linux distributions**, **macOS**, **BSD**, and minimal remote **SSH servers or containers**.

## Features

- **Native Catppuccin Mocha Colorscheme**: Complete 24-bit pastel palette (`#1e1e2e` Base, `#cdd6f4` Text, `#89b4fa` Blue, `#cba6f7` Mauve, `#a6e3a1` Green, `#fab387` Peach) implemented without external plugins.
- **Dynamic Statusline**: Color-coded live mode badge (`NORMAL`, `INSERT`, `VISUAL`, `REPLACE`, `COMMAND`), file path, modified/read-only indicators (`[+]`, `[RO]`), live line-number mode (`NUM:REL` / `NUM:ABS` / `NUM:OFF`), filetype, encoding, and cursor coordinates.
- **Instant Line-Number Toggle (Relative ↔ Absolute)**:
  - `<Space>un`, `<Space>rn`, `<Space>n`, or `<F3>`: Immediately toggle between hybrid relative and absolute line numbers.
  - `<Space>uN`: Toggle line numbers completely on or off.
- **Strict XDG Cleanliness**: No `.swp` or backup files cluttering working directories; persistent undo (`~/.local/state/vim/undo`) and `viminfo` (`~/.local/state/vim/viminfo`) live cleanly inside `~/.local/state/vim`.
- **Synchronized with Neovim (`Leader = <Space>`)**: Identical muscle memory across `vim` and `nvim` for window splits, buffers, clipboard, and UI toggles.

---

## Custom Keybindings & Commands

Full reference: [Vim Keybindings & Commands Documentation](https://vim-config.readthedocs.io/en/latest/keybindings/).

| Keybinding / Command | Mode | Action |
| :--- | :--- | :--- |
| `<Space>un` / `<Space>rn` / `<Space>n` / `<F3>` | Normal (`<F3>` also Insert) | Toggle **Relative (Hybrid) ↔ Absolute** line numbers |
| `<Space>uN` | Normal | Toggle line numbers completely **On / Off** |
| `:ToggleRelNum` | Command | Ex command to toggle relative ↔ absolute line numbers |
| `Ctrl + h / j / k / l` | Normal | Navigate between split windows (left / down / up / right) |
| `<Space>wv` / `<Space>ws` | Normal | Split window vertically (`:vsplit`) / horizontally (`:split`) |
| `<Space>wc` / `<Space>we` | Normal | Close active split (`:close`) / Equalize split sizes (`<C-w>=`) |
| `Shift + H` / `Shift + L` | Normal | Switch to previous (`:bprevious`) / next (`:bnext`) buffer |
| `<Space>bd` | Normal | Delete/close active buffer (`:bdelete`) |
| `<Space>y` / `<Space>Y` | Normal / Visual | Copy selection / line to system clipboard (`+` register) |
| `<Space>uw` / `<Space>ul` | Normal | Toggle line wrap (`:set wrap!`) / invisible chars (`:set list!`) |
| `<Esc>` | Normal | Clear active search highlighting (`:nohlsearch`) |
| `<` / `>` | Visual | Indent / unindent block while keeping visual selection active |
| `Ctrl + d` / `Ctrl + u` | Normal | Scroll half-page down / up and center cursor (`zz`) |

---

## Installation

### 1. Standalone (`~/.config/vim` & `~/.vimrc`)

Works on any Linux distribution, macOS, or remote SSH server:

```bash
git clone https://github.com/MichaelWeissDEV/vim-config.git ~/.config/vim
ln -sfn ~/.config/vim/vimrc ~/.vimrc
mkdir -p ~/.local/state/vim/undo
```

### 2. Inside the Arch Linux Dotfiles Ecosystem (`~/git/dotfiles`)

This repository is embedded as a **Git Subtree** under `vim/` in [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) and linked automatically to `~/.config/vim` and `~/.vimrc`:

```bash
# Update EVERYTHING (system, dotfiles & all subtrees) via the central CLI:
adot update
# (also available as: arch-dot update / arch-dotfiles update)

# Pull only the vim subtree from upstream:
adot update vim

# Inspect live status & Vim keybindings:
adot status
adot keys vim

# Push local commits from ~/git/dotfiles/vim back to upstream:
adot push vim
```

<details>
<summary><b>Manual <code>git subtree</code> commands</b></summary>

```bash
# Add remote (one-time):
git remote add vim-remote https://github.com/MichaelWeissDEV/vim-config.git

# Pull updates from upstream:
git fetch vim-remote main
git subtree pull --prefix=vim vim-remote main --squash -m "Update vim subtree from upstream"

# Push local changes to upstream:
git subtree push --prefix=vim vim-remote main
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
| **Kitty (`kitty-config`)** | [`MichaelWeissDEV/kitty-config`](https://github.com/MichaelWeissDEV/kitty-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Foot (`foot-config`)** | [`MichaelWeissDEV/foot-config`](https://github.com/MichaelWeissDEV/foot-config) | [Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) |
| **Vim (`vim-config`)** | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
