# Terminal Emulators

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

The [`arch-dotfiles`](https://arch-dotfiles.readthedocs.io/en/latest/) ecosystem provides three pre-configured terminal emulators: **Ghostty**, **Kitty**, and **Foot**. Each is tuned to deliver identical typography, window transparency, and **Catppuccin Mocha** color fidelity.

---

## Shared Aesthetic Standards

Regardless of which terminal emulator is active, you experience consistent visual behavior:

- 🎨 **Palette**: Official **Catppuccin Mocha** pastel colors (`#1e1e2e` base, `#cdd6f4` text, `#89b4fa` pastel blue selection, `#f5e0dc` rosewater block cursor).
- 🪟 **Transparency**: Uniform `0.90` background opacity for smooth compositing on Wayland.
- 🔤 **Typography**: **JetBrainsMonoNL Nerd Font** (`10.5pt`, No Ligatures variant) with `8px` window padding, complete Powerline/Nerd Font glyphs, and zero operator ligatures (`==`, `->`, `*` remain unmodified).
- 🐚 **Default Shell**: Automatically launches into `/usr/bin/zsh` with Oh My Zsh (see [Shell Guide](shell.md)).
- 🔔 **Bell**: Audio bell disabled across all emulators (`enable_audio_bell no`, `urgent=no`).

---

## Terminal Comparison & Documentation Links

| Feature | Ghostty | Kitty | Foot |
| :--- | :--- | :--- | :--- |
| **Engine / Architecture** | Zig + OpenGL/Vulkan | C/Python + OpenGL | C + Wayland Native |
| **Memory Footprint** | Low (~35 MB) | Moderate (~50 MB) | Ultra-Low (~15 MB) |
| **Wayland Support** | Native Wayland (GTK4) | Native Wayland | Native Wayland |
| **Tab Management** | Native GTK4 tabs | Powerline tabs | Multiplexer ([tmux](https://tmux-config.readthedocs.io/en/latest/)) |
| **Config Reload Shortcut** | <kbd>Ctrl+Shift+,</kbd> | <kbd>Ctrl+Shift+F5</kbd> | Automatic / restart |
| **Repository** | [MichaelWeissDEV/ghostty-config](https://github.com/MichaelWeissDEV/ghostty-config) | [MichaelWeissDEV/kitty-config](https://github.com/MichaelWeissDEV/kitty-config) | [MichaelWeissDEV/foot-config](https://github.com/MichaelWeissDEV/foot-config) |
| **Documentation** | [**ghostty-config.readthedocs.io**](https://ghostty-config.readthedocs.io/en/latest/) | [**kitty-config.readthedocs.io**](https://kitty-config.readthedocs.io/en/latest/) | [Foot section](#3-foot-configfootfootini) · built-in man pages (`man foot.ini`) |

---

## Terminal Details

### 1. Ghostty (`~/.config/ghostty/config`)

Managed via the Git subtree `MichaelWeissDEV/ghostty-config` (`adot update ghostty`; see [Git Subtrees](subtrees.md)). Ghostty is a modern GPU-accelerated terminal written in Zig featuring native GTK4/Wayland rendering and zero window decorations (`window-decoration = none`).

- **Config path**: `~/.config/ghostty/config`
- **GitHub Repository**: [MichaelWeissDEV/ghostty-config](https://github.com/MichaelWeissDEV/ghostty-config)
- **Full Documentation**: [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/)

### 2. Kitty (`~/.config/kitty/kitty.conf`)

Managed via the Git subtree `MichaelWeissDEV/kitty-config` (`adot update kitty`; see [Git Subtrees](subtrees.md)). Kitty provides mature graphics protocols, kitten automation scripts, dynamic background opacity, and a custom Catppuccin Powerline tab bar.

- **Config path**: `~/.config/kitty/kitty.conf`
- **GitHub Repository**: [MichaelWeissDEV/kitty-config](https://github.com/MichaelWeissDEV/kitty-config)
- **Full Documentation**: [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/)

### 3. Foot (`~/.config/foot/foot.ini`)

Managed via the Git subtree `MichaelWeissDEV/foot-config` (`adot update foot`; see [Git Subtrees](subtrees.md)). Foot is an ultra-lightweight terminal designed strictly for Wayland. It starts instantaneously and operates with minimal CPU and memory overhead.

- **Config path**: `~/.config/foot/foot.ini`
- **GitHub Repository**: [MichaelWeissDEV/foot-config](https://github.com/MichaelWeissDEV/foot-config)
- **Documentation**: This guide and the built-in `man foot.ini` reference

---

## Selecting Your Default Terminal in Hyprland

In Hyprland (`~/.config/hypr/hyprland.lua`), the default terminal shortcut (<kbd>Super</kbd> + <kbd>Return</kbd> or <kbd>Super</kbd> + <kbd>Q</kbd>) is bound to Kitty (see [Hyprland Keybindings](hyprland.md#application-launchers--system-controls)):

```lua
-- ~/.config/hypr/hyprland.lua
local terminal = "kitty"
```

To switch your default terminal to Ghostty or Foot, change `local terminal = "ghostty"` (or `"foot"`) in `hyprland.lua`.

---

## Connected Dotfiles Ecosystem

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** *(Main System)* | [MichaelWeissDEV/dotfiles](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [MichaelWeissDEV/nvim-config](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [MichaelWeissDEV/tmux-config](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Ghostty (`ghostty-config`)** | [MichaelWeissDEV/ghostty-config](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [MichaelWeissDEV/kitty-config](https://github.com/MichaelWeissDEV/kitty-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Foot (`foot-config`)** | [MichaelWeissDEV/foot-config](https://github.com/MichaelWeissDEV/foot-config) | [Terminals Guide](terminals.md) |
| **Vim (`vim-config`)** | [MichaelWeissDEV/vim-config](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
