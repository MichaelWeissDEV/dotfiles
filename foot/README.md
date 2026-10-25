<div align="center">

# Foot Configuration

**A lightweight, Wayland-native terminal configuration in Catppuccin Mocha.**

Arch Linux · Wayland · Foot · Catppuccin Mocha

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/terminals/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Arch Linux | Wayland](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[**Dotfiles Ecosystem**](https://github.com/MichaelWeissDEV/dotfiles) ·
[Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) ·
[Configuration (`foot.ini`)](foot.ini)

</div>

---

## Overview

This repository contains the standalone **Foot** terminal configuration used by the [`arch-dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) ecosystem. Foot is a fast, low-memory terminal emulator built specifically for Wayland.

The configuration is embedded into the main dotfiles repository as a **Git subtree**, so it is available immediately after cloning the dotfiles without submodules. It can also be used entirely on its own.

## Features

- **Catppuccin Mocha palette**: complete 16-color regular and bright palette matching the Ghostty and Kitty configurations.
- **Consistent transparency**: `alpha=0.90`, synchronized with the other terminals in the ecosystem.
- **Clean typography**: `JetBrainsMonoNL Nerd Font` (`No Ligatures` variant) at `10.5pt` with `8x8` padding — full Nerd Font icon coverage without ligatures (`==`, `->`, `*` stay unmodified).
- **Minimal cursor styling**: a solid block cursor in Rosewater (`#f5e0dc`) on Base (`#1e1e2e`).
- **Dark color scheme**: defined through `[colors-dark]`, with matching selection colors.
- **Quiet operation**: no urgent hints or desktop notifications on bell events.
- **Shell integration**: launches directly into `/usr/bin/zsh`.

## Configuration

| File | Target path | Description |
| :--- | :--- | :--- |
| [`foot.ini`](foot.ini) | `~/.config/foot/foot.ini` | Main configuration (shell, font, padding, opacity, cursor, palette) |

### Key settings

| Setting | Value |
| :--- | :--- |
| `shell` | `/usr/bin/zsh` |
| `font` | `JetBrainsMonoNL Nerd Font:size=10.5` |
| `pad` | `8x8` |
| `alpha` | `0.90` |
| `background` / `foreground` | `#1e1e2e` / `#cdd6f4` |
| `cursor` | Block, `#1e1e2e` on `#f5e0dc` |
| `selection-background` / `selection-foreground` | `#313244` / `#cdd6f4` |

## Installation

### Standalone

Clone the repository directly into the Foot configuration directory:

```bash
git clone https://github.com/MichaelWeissDEV/foot-config.git ~/.config/foot
```

If `~/.config/foot` already exists, copy the configuration file instead:

```bash
git clone https://github.com/MichaelWeissDEV/foot-config.git /tmp/foot-config
mkdir -p ~/.config/foot
cp /tmp/foot-config/foot.ini ~/.config/foot/foot.ini
```

### As a Git subtree

This repository is embedded under `foot/` in [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles):

```bash
cd ~/git/dotfiles

# One-time setup
git remote add foot-remote https://github.com/MichaelWeissDEV/foot-config.git

# Add the subtree (only when foot/ does not exist yet)
git fetch foot-remote main
git subtree add --prefix=foot foot-remote main --squash -m "Add foot config as git subtree"

# Pull upstream changes
git fetch foot-remote main
git subtree pull --prefix=foot foot-remote main --squash -m "Update foot subtree from upstream"

# Push local changes back upstream
git subtree push --prefix=foot foot-remote main
```

The dotfiles helper script wraps the same workflow:

```bash
adot update foot   # pull the latest configuration
adot push foot     # push local subtree commits upstream
```

## Requirements

- **Foot** — install with `sudo pacman -S foot` on Arch Linux.
- **JetBrainsMonoNL Nerd Font** — install with `sudo pacman -S ttf-jetbrains-mono-nerd`.
- **Zsh** — installed at `/usr/bin/zsh`; adjust `shell=` in `foot.ini` if your shell lives elsewhere.
- **Wayland compositor** — Foot runs natively on Wayland (e.g. Hyprland or Sway).

## Ecosystem

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** | [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Foot (`foot-config`)** | [`MichaelWeissDEV/foot-config`](https://github.com/MichaelWeissDEV/foot-config) | [Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) |
| **Ghostty (`ghostty-config`)** | [`MichaelWeissDEV/ghostty-config`](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [`MichaelWeissDEV/kitty-config`](https://github.com/MichaelWeissDEV/kitty-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [`MichaelWeissDEV/nvim-config`](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [`MichaelWeissDEV/tmux-config`](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Vim (`vim-config`)** | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.
