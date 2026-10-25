<div align="center">

# Scripts & Automation — Arch Dotfiles

**Unified ecosystem CLI (`adot` / `arch-dot`), installer, and Git subtree maintainer.**

Arch Linux · Bash · Automation · Git Subtrees

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Installation Guide](https://img.shields.io/badge/docs-Installation%20Guide-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/installation/)
[![Subtrees Guide](https://img.shields.io/badge/docs-Git%20Subtrees-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/subtrees/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Shell & CLI Guide](https://arch-dotfiles.readthedocs.io/en/latest/shell/) ·
[Installation Guide](https://arch-dotfiles.readthedocs.io/en/latest/installation/) ·
[Git Subtrees](https://arch-dotfiles.readthedocs.io/en/latest/subtrees/) ·
[CLI Program (`adot`)](adot)

</div>

---

## Overview

This directory contains the central command-line executable **`adot`** (also symlinked as `arch-dot` and `arch-dotfiles`) and underlying automation scripts for provisioning, updating, and syncing the **Arch Linux Dotfiles** ecosystem (`arch-dotfiles`).

## Script Inventory

| Script | Global Command / Target | Description |
| :--- | :--- | :--- |
| **[`adot`](adot)** | `~/.local/bin/adot`, `~/.local/bin/arch-dot`, `~/.local/bin/arch-dotfiles` | Unified CLI program managing updates, status inspection, keybinding tables, and docs |
| **[`install.sh`](install.sh)** | `./scripts/install.sh [all\|links\|packages\|subtrees\|omz]` | Complete Arch Linux installer (packages, Oh My Zsh, subtrees, symlinks, services) |
| **[`install-links.sh`](install-links.sh)** | `adot links` (or `cfg-links`) | Portable symlink generator (links repo configs to `~/.config`, `$HOME`, `~/.local/bin`) |
| **[`update-subtrees.sh`](update-subtrees.sh)** | `adot update subtrees` / `adot subtrees` | Pulls, verifies, and pushes the 6 standalone Git subtrees using squash merges |
| **[`install-wallpapers.sh`](install-wallpapers.sh)** | `adot wallpapers [URL\|--update]` | Clones or updates the private wallpaper repository in `pictures/` |

## Quick Command Reference (`adot`)

```bash
adot update           # Full update: system packages, repo, all 6 subtrees, OMZ, symlinks
adot update nvim      # Update only a single subtree (nvim | tmux | ghostty | kitty | foot | vim)
adot status [--fetch] # Live dashboard: repo, symlinks, all 6 subtrees, OMZ, pacman
adot list [category]  # List managed modules, subtrees, keys, commands, scripts, packages, docs
adot keys [section]   # Print keybinding tables (hypr | nvim | vim | tmux | terminals | shell | all)
adot commands         # Print custom shell commands, functions (j, ji, y, ...), and aliases
adot scripts          # Print CLI binaries in ~/.local/bin and scripts in ~/git/dotfiles
adot docs             # Print documentation URLs and GitHub repository links
adot links            # Re-create and verify all configuration symlinks
```

---

## Connected Dotfiles Ecosystem

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** *(Main System)* | [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [`MichaelWeissDEV/nvim-config`](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [`MichaelWeissDEV/tmux-config`](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Ghostty (`ghostty-config`)** | [`MichaelWeissDEV/ghostty-config`](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [`MichaelWeissDEV/kittiy-config`](https://github.com/MichaelWeissDEV/kittiy-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Vim (`vim-config`)** | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
