<div align="center">

# Waybar Configuration — Catppuccin Mocha

**A clean, modular status bar for Hyprland with power controls and audio telemetry.**

Arch Linux · Hyprland · Waybar · Catppuccin Mocha

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Waybar Docs](https://img.shields.io/badge/docs-Waybar%20Guide-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/waybar/)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Arch Linux](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Waybar Guide](https://arch-dotfiles.readthedocs.io/en/latest/waybar/) ·
[Hyprland Guide](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/) ·
[Configuration (`config.jsonc`)](config.jsonc) ·
[Stylesheet (`style.css`)](style.css)

</div>

---

## Overview

This directory contains the **Waybar** configuration for the **Arch Linux + Hyprland** desktop ecosystem (`arch-dotfiles`), styled in the official **Catppuccin Mocha** pastel theme with rounded pill margins.

## Configuration Files

| File | Target Path | Description |
| :--- | :--- | :--- |
| **[`config.jsonc`](config.jsonc)** | `~/.config/waybar/config.jsonc` | Module layout, clock/calendar format, audio/battery thresholds, intervals |
| **[`style.css`](style.css)** | `~/.config/waybar/style.css` | Catppuccin Mocha CSS styling, pastel pill borders, and active workspace highlights |
| **[`power_menu.xml`](power_menu.xml)** | `~/.config/waybar/power_menu.xml` | GTK dropdown power menu definition (Shutdown, Reboot, Suspend, Lock, Logout) |

## Key Features

- **Workspaces Indicator**: Live indicators of active and occupied workspaces per monitor.
- **Clock & Calendar**: 24-hour live clock with interactive calendar popup on click.
- **Audio & Battery**: PulseAudio/PipeWire volume with scroll-wheel control, mute toggle, and battery percentage.
- **Network Controls**: Wi-Fi SSID and link status with right-click opening `nmtui`.
- **Dual-Mode Power Menu**:
  - **Left-click on `󰐥`**: Compact GTK dropdown menu (`power_menu.xml`).
  - **Right-click on `󰐥`**: Keyboard-driven Fuzzel menu (`powermenu.sh`).
- **Live Reload**: Press `SUPER + SHIFT + B` or run `killall waybar && waybar &`.

---

## Connected Dotfiles Ecosystem

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** *(Main System)* | [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [`MichaelWeissDEV/nvim-config`](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [`MichaelWeissDEV/tmux-config`](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Ghostty (`ghostty-config`)** | [`MichaelWeissDEV/ghostty-config`](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [`MichaelWeissDEV/kitty-config`](https://github.com/MichaelWeissDEV/kitty-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Foot (`foot-config`)** | [`MichaelWeissDEV/foot-config`](https://github.com/MichaelWeissDEV/foot-config) | [Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) |
| **Vim (`vim-config`)** | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
