# Arch Dotfiles Ecosystem Documentation

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Platform: Arch Linux](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Linux%20%7C%20macOS-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/MichaelWeissDEV/dotfiles/blob/main/LICENSE)

[**Documentation Hub**](index.md) ·
[Installation](installation.md) ·
[Hyprland Desktop](hyprland.md) ·
[Waybar Panel](waybar.md) ·
[Terminals](terminals.md) ·
[Shell & CLI](shell.md) ·
[Git Subtrees](subtrees.md)

Welcome to the comprehensive documentation for the **Arch Linux Dotfiles Ecosystem** (`arch-dotfiles`). This central repository (`~/git/dotfiles`) unites a complete Wayland desktop environment (**Arch Linux + Hyprland + Waybar + Fuzzel**) with customized GPU terminals, shells, multiplexers, and modal text editors styled uniformly in **Catppuccin Mocha**.

:::{note}
**Designed for Arch Linux — Adaptable to Any System**: Every configuration in this repository is built so that anyone can install the entire environment out-of-the-box on **Arch Linux** using a single command (`./scripts/install.sh` or `arch-dot install`). Because each component is cleanly modularized and the six core terminal/editor configurations live in their own self-contained repositories, you can also run this setup (or individual sub-projects) on **other Linux distributions, macOS, or WSL2** with only minimal adjustments (such as package manager names or binary paths).
:::

---

## Architecture Overview

```text
                                ┌────────────────────────────────┐
                                │   Arch Dotfiles Hub            │
                                │   ~/git/dotfiles (arch-dot)    │
                                └───────────────┬────────────────┘
                                                │
              ┌───────────────────┬─────────────┴───────┬───────────────────┐
              │                   │                     │                   │
              ▼                   ▼                     ▼                   ▼
     ┌─────────────────┐ ┌─────────────────┐   ┌─────────────────┐ ┌─────────────────┐
     │    Hyprland     │ │     Waybar      │   │  Shell & CLI    │ │    Wallpapers   │
     │ Instant Switch  │ │ Top Status Bar  │   │  arch-dot CLI   │ │ hyprpaper + TUI │
     │ Slots 1..10/F1..│ │ Power Dropdown  │   │  Zsh + Fzf/Yazi │ │ Multi-Monitor   │
     └─────────────────┘ └─────────────────┘   └─────────────────┘ └─────────────────┘
                                                │
                                                │ (Git Subtrees)
              ┌───────────────┬───────────────┬─┼──────────────┬──────────────┬──────────────┬────────────┐
              ▼               ▼               ▼                ▼              ▼              ▼
       nvim-config      tmux-config     ghostty-config    kitty-config    foot-config     vim-config
        (Neovim)          (tmux)          (Ghostty)        (Kitty)         (Foot)          (Vim)
```

The ecosystem separates concerns into clean layers:
1. **[Unified CLI Program (`adot` / `arch-dot` / `arch-dotfiles`)](shell.md#managing-everything-with-adot--arch-dot)**: Central command-line program in `~/.local/bin` that installs or updates everything (`adot install`, `adot update`), updates individual subtrees (`adot update nvim`), inspects live system/repo/subtree state (`adot status`), and lists all modules, custom commands, scripts, and keybindings (`adot list`, `adot keys`, `adot commands`, `adot scripts`).
2. **[Desktop Shell (`hypr/`)](hyprland.md)**: Hyprland tiling compositor tuned for instant reaction speed (zero animation lag), multi-monitor window jumping, cross-monitor slot pinning (`1..10` and `F1..F4`), and interactive fuzzy window switching (`windowswitcher.sh`).
3. **[Status Bar & Launcher (`waybar/`, `fuzzel/`)](waybar.md)**: Waybar top panel with Catppuccin Mocha styling, audio/network controls, and a dual-mode power menu, paired with Fuzzel for app launching and `sudo` askpass prompts.
4. **[Multi-Monitor Wallpapers (`wallpaper/`)](hyprland.md#wallpaper-management-hyprpaper)**: Custom `wallpaper` CLI and Fuzzel TUI managing `hyprpaper` with a global default and independent per-monitor overrides.
5. **[Terminals (`ghostty/`, `kitty/`, `foot/`)](terminals.md)**: Ghostty, Kitty, and Foot all tuned to `0.90` background opacity with identical `JetBrainsMonoNL Nerd Font` (no-ligature) typography.
6. **[Shell Environment (`zsh/`, `yazi/`)](shell.md)**: Zsh with Oh My Zsh, Catppuccin Mocha syntax highlighting, autosuggestions, smart directory jumping via `j` / `ji` (powered under the hood by `zoxide`), and fast aliases (`arch-dot`, `nv`, `v`, `y`, `tm`, `fznv`, `fzv`).
7. **[Independent Git Subtrees](subtrees.md)**: Core editor and terminal configs reside in their own GitHub repositories with dedicated documentation, embedded here via Git subtrees for zero-submodule cloning simplicity.

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
Kitty (kitty-config) <https://kitty-config.readthedocs.io/en/latest/>
Vim (vim-config) <https://vim-config.readthedocs.io/en/latest/>
```

---

## Connected Documentation Hub (Read the Docs)

All six projects in the ecosystem have dedicated **Read the Docs** manuals that cross-link to one another:

| Project | Role | GitHub Repository | Documentation |
| :--- | :--- | :--- | :--- |
| **`arch-dotfiles`** *(Main Hub)* | Full Arch Linux & Hyprland Ecosystem | [MichaelWeissDEV/dotfiles](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **`nvim-config`** | Reproducible, Offline-Capable Neovim IDE | [MichaelWeissDEV/nvim-config](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **`tmux-config`** | Portable, Fast Terminal Multiplexer | [MichaelWeissDEV/tmux-config](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **`ghostty-config`** | Minimalist GPU Terminal (Ghostty) | [MichaelWeissDEV/ghostty-config](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **`kitty-config`** | Scriptable GPU Terminal (Kitty) | [MichaelWeissDEV/kitty-config](https://github.com/MichaelWeissDEV/kitty-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **`foot-config`** | Ultra-Lightweight Wayland Terminal (Foot) | [MichaelWeissDEV/foot-config](https://github.com/MichaelWeissDEV/foot-config) | [Terminals Guide](terminals.md) |
| **`vim-config`** | Zero-Plugin Standalone Vim | [MichaelWeissDEV/vim-config](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |

---

## Quick Start

### 1. Clone the Central Repository

```bash
mkdir -p ~/git
git clone https://github.com/MichaelWeissDEV/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

### 2. Run the Automated Installer

The installer provisions `pacman` packages, symlinks, the `arch-dot` / `arch-dotfiles` CLI, Oh My Zsh plugins, and system services:

```bash
# Complete Arch Linux system setup:
./scripts/install.sh

# Or link configuration files only (works on any Linux/macOS system without sudo):
./scripts/install-links.sh
```

### 3. Manage & Update Everything (`adot`)

From anywhere in your terminal, inspect status, list keybindings/commands, or update everything (or individual subtrees) with **`adot`** (also available as `arch-dot` or `arch-dotfiles`):

```bash
adot update           # Update everything (pacman, dotfiles, all 6 subtrees, wallpapers, OMZ & symlinks)
adot update nvim      # Update only a single subtree (nvim | tmux | ghostty | kitty | foot | vim)
adot status           # Show live status of repo, symlinks, subtrees, Oh My Zsh, zoxide & packages
adot list             # List all managed modules, subtrees, scripts, commands & docs
adot keys [section]   # List custom keybindings (hypr | nvim | vim | tmux | terminals | shell | all)
adot commands         # List all custom CLI commands, shell functions (j/ji, y, ...) & aliases
adot scripts          # List all CLI binaries and helper scripts
```

### 4. Launch the Desktop

After logging into the Arch Linux TTY, start the Hyprland session:

```bash
start-hyprland
```
