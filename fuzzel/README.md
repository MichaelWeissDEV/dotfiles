<div align="center">

# Fuzzel Configuration — Catppuccin Mocha

**Fast Wayland application launcher, dmenu provider, and graphical sudo askpass prompt.**

Arch Linux · Hyprland · Fuzzel · Catppuccin Mocha

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Hyprland Docs](https://img.shields.io/badge/docs-Hyprland%20Guide-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Arch Linux](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Hyprland Guide](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/) ·
[Waybar Guide](https://arch-dotfiles.readthedocs.io/en/latest/waybar/) ·
[Configuration (`fuzzel.ini`)](fuzzel.ini)

</div>

---

## Overview

This directory contains the **Fuzzel** configuration for the **Arch Linux + Hyprland** dotfiles ecosystem (`arch-dotfiles`), styled in the official **Catppuccin Mocha** pastel theme.

## Configuration Files

| File | Target Path | Description |
| :--- | :--- | :--- |
| **[`fuzzel.ini`](fuzzel.ini)** | `~/.config/fuzzel/fuzzel.ini` | Main Fuzzel configuration file (fonts, dimensions, colors, borders) |

## Use Cases

1. **Application Launcher**: Press `SUPER + Space` (or `SUPER + D`) to filter and launch desktop applications. Type a shell command and press `SHIFT + Enter` to execute directly.
2. **Graphical `sudo` Prompt**: Used by `~/.config/hypr/askpass.sh` (`fuzzel --dmenu --password`) for Wayland-native privilege escalation.
3. **Power Menu**: Used by `~/.config/hypr/powermenu.sh` (`SUPER + Escape`) for the keyboard-driven shutdown/reboot menu.
4. **Wallpaper Switcher**: Used by `wallpaper` (`SUPER + SHIFT + W`) for interactive background selection across monitors.

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
