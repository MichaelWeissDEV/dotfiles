# Dotfiles Ecosystem Documentation

Welcome to the comprehensive documentation for the **Dotfiles Ecosystem** by Michael Weiss. This central repository unites a full Wayland desktop environment (Arch Linux + Hyprland) with customized terminals, shells, multiplexers, and modal text editors styled uniformly in **Catppuccin Mocha**.

:::{note}
**Author Note**: This is Michael Weiss' personal developer setup. Built on the philosophy of **instant reaction times**, **zero visual distraction**, and **uncompromising reproducibility**, it is structured so anyone can install it on Arch Linux or adapt individual components to their own environment.
:::

---

## Architecture Overview

```text
                               ┌────────────────────────────────┐
                               │   Dotfiles Hub (Arch Linux)    │
                               │     ~/git/dotfiles             │
                               └───────────────┬────────────────┘
                                               │
             ┌───────────────────┬─────────────┴───────┬───────────────────┐
             │                   │                     │                   │
             ▼                   ▼                     ▼                   ▼
    ┌─────────────────┐ ┌─────────────────┐   ┌─────────────────┐ ┌─────────────────┐
    │    Hyprland     │ │     Waybar      │   │  Shell & Tools  │ │    Wallpapers   │
    │ Instant Switch  │ │ Top Status Bar  │   │  Zsh + Aliases  │ │ hyprpaper + CLI │
    │ Slots 1..10/F1..│ │ Power Dropdown  │   │  Fzf + Yazi     │ │ Multi-Monitor   │
    └─────────────────┘ └─────────────────┘   └─────────────────┘ └─────────────────┘
                                               │
                                               │ (Git Subtrees)
             ┌─────────────────┬───────────────┼─────────────────┬─────────────────┐
             ▼                 ▼               ▼                 ▼                 ▼
      nvim-config         tmux-config     ghostty-config    kittiy-config     vim-config
       (Neovim)             (tmux)          (Ghostty)         (Kitty)           (Vim)
```

The system separates concerns cleanly:
1. **Desktop Shell**: Hyprland tiling compositor configured with instant response keybindings, multi-monitor window jumping, cross-monitor slot pinning (`1..10` and `F1..F4`), and interactive fuzzy switching.
2. **Status Bar & UI**: Waybar statusbar with Catppuccin Mocha styling, hardware sensors, network indicators, and a one-click power dropdown menu.
3. **Terminals**: Ghostty, Kitty, and Foot all tuned to `0.90` opacity with identical JetBrainsMono Nerd Font rendering.
4. **Shell Environment**: Zsh with Oh My Zsh, custom Catppuccin prompt, autosuggestions, syntax highlighting, and productive aliases (`nv`, `v`, `y`, `tm`, `fznv`, `fzv`).
5. **Independent Git Subtrees**: Core editor and terminal configs reside in their own GitHub repositories, embedded here via Git subtrees for zero-submodule cloning simplicity.

---

## Table of Contents

```{toctree}
:maxdepth: 2
:caption: System Guides

installation
hyprland
waybar
terminals
shell
subtrees
```

```{toctree}
:caption: Dedicated Sub-Project Docs
:hidden:

Neovim (nvim-config) <https://nvim-config.readthedocs.io/en/latest/>
tmux (tmux-config) <https://tmux-config.readthedocs.io/en/latest/>
Ghostty (ghostty-config) <https://ghostty-config.readthedocs.io/en/latest/>
Kitty (kittiy-config) <https://kittiy-config.readthedocs.io/en/latest/>
Vim (vim-config) <https://vim-config.readthedocs.io/en/latest/>
```

---

## Sub-Project Documentation Hub

Each core component has its own dedicated Read the Docs manual with exhaustive configuration details, keybinding matrices, and installation paths:

| Sub-Project | Component | Repository | Documentation |
| :--- | :--- | :--- | :--- |
| **nvim-config** | Neovim IDE | [MichaelWeissDEV/nvim-config](https://github.com/MichaelWeissDEV/nvim-config) | [Read the Docs](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux-config** | Terminal Multiplexer | [MichaelWeissDEV/tmux-config](https://github.com/MichaelWeissDEV/tmux-config) | [Read the Docs](https://tmux-config.readthedocs.io/en/latest/) |
| **ghostty-config** | Fast GPU Terminal | [MichaelWeissDEV/ghostty-config](https://github.com/MichaelWeissDEV/ghostty-config) | [Read the Docs](https://ghostty-config.readthedocs.io/en/latest/) |
| **kittiy-config** | Scriptable GPU Terminal | [MichaelWeissDEV/kittiy-config](https://github.com/MichaelWeissDEV/kittiy-config) | [Read the Docs](https://kittiy-config.readthedocs.io/en/latest/) |
| **vim-config** | Zero-Plugin Fallback Vim | [MichaelWeissDEV/vim-config](https://github.com/MichaelWeissDEV/vim-config) | [Read the Docs](https://vim-config.readthedocs.io/en/latest/) |

---

## Quick Start

### 1. Clone the Central Repository

```bash
mkdir -p ~/git
git clone https://github.com/MichaelWeissDEV/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

### 2. Run the Automated Installer

The installer configures pacman packages, symlinks, Oh My Zsh plugins, and system services:

```bash
# Complete system setup:
./scripts/install.sh

# Or link configuration files only:
./scripts/install-links.sh
```

### 3. Launch the Desktop

After logging into the Arch Linux TTY, start the Hyprland session:

```bash
start-hyprland
```
