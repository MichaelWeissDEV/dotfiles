# Waybar Status Bar

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

Waybar provides the top desktop panel for the [Hyprland](hyprland.md) session, offering at-a-glance telemetry, workspace state, audio controls, and an integrated system power menu.

---

## Panel Layout

```text
┌──────────────────────────────────┬──────────────┬──────────────────────────────────┐
│  1 2 3 4 5  Window Title          │  14:32:05    │  󰕾 65%  󰂀 82%  󰤨 WiFi  󰐥   │
└──────────────────────────────────┴──────────────┴──────────────────────────────────┘
  (Workspaces / Title)               (Clock)        (Audio / Battery / Net / Power)
```

The panel is configured across three primary sectors:

### 1. Left Sector
- **Workspaces (`hyprland/workspaces`)**: Visual indicator of active and occupied workspaces with distinct pastel highlighting for the currently focused monitor.
- **Active Window Title (`hyprland/window`)**: Truncated title of the focused application.

> The application launcher and wallpaper selector are intentionally **not** in Waybar. Start the launcher with <kbd>Super</kbd> + <kbd>Space</kbd> (or <kbd>Super</kbd> + <kbd>D</kbd>) and the wallpaper TUI with <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd> or the `wallpaper` command (see [Hyprland Guide](hyprland.md#wallpaper-management-hyprpaper)).

### 2. Center Sector
- **Clock & Calendar**: Displays live 24-hour time and date (`HH:mm:ss · YYYY-MM-DD`). Clicking opens calendar info.

### 3. Right Sector
- **Audio (`pulseaudio`)**: Volume percentage and mute indicator. Scroll to adjust volume; left-click to toggle mute; right-click to open audio mixer.
- **Battery (`battery`)**: State of charge, remaining runtime, and charging status.
- **Network (`network`)**: Wireless SSID, signal strength, or ethernet link speed. Right-click opens `nmtui` in a floating terminal.
- **Power Menu (`󰐥`)**: System power controls.

---

## Power Menu Integration

The power icon (`󰐥`) offers two interaction modes:

1. **Left-Click (GTK Menu)**:
   Immediately renders a discrete popup menu (`power_menu.xml`) directly beneath the bar:
   - `󰐥 Shutdown` (`systemctl poweroff`)
   - `󰜉 Reboot` (`systemctl reboot`)
   - `󰤄 Suspend` (`systemctl suspend`)
   - `󰌾 Lock Screen` (`hyprlock`)
   - `󰍃 Logout` (`hyprctl dispatch exit`)

2. **Right-Click (Fuzzel Picker)**:
   Launches the keyboard-driven menu (`powermenu.sh`) powered by `fuzzel`, allowing quick navigation with arrow keys and <kbd>Enter</kbd>. (Also accessible globally via <kbd>Super</kbd> + <kbd>Escape</kbd>; see [Hyprland Keybindings](hyprland.md#application-launchers--system-controls)).

---

## Reloading Waybar

To reload Waybar after editing its styling or JSON configuration:

```bash
# Via keybinding:
Super + Shift + b

# Via terminal:
killall waybar && waybar &
```

---

## Configuration Files

The Waybar configuration is stored in `~/.config/waybar/`:

- **Main Configuration**: [`config.jsonc`](https://github.com/MichaelWeissDEV/dotfiles/blob/main/waybar/config.jsonc) — module definitions, layout sectors, formatting, and update intervals.
- **Catppuccin Mocha Styling**: [`style.css`](https://github.com/MichaelWeissDEV/dotfiles/blob/main/waybar/style.css) — custom CSS styling with rounded pill geometry and pastel accents.
- **Power Dropdown XML**: [`power_menu.xml`](https://github.com/MichaelWeissDEV/dotfiles/blob/main/waybar/power_menu.xml) — GTK menu definition for the power dropdown button.

---

## Connected Dotfiles Ecosystem

| Component | Repository | Documentation |
| :--- | :--- | :--- |
| **Arch Dotfiles Hub** *(Main System)* | [MichaelWeissDEV/dotfiles](https://github.com/MichaelWeissDEV/dotfiles) | [arch-dotfiles.readthedocs.io](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **Neovim (`nvim-config`)** | [MichaelWeissDEV/nvim-config](https://github.com/MichaelWeissDEV/nvim-config) | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **tmux (`tmux-config`)** | [MichaelWeissDEV/tmux-config](https://github.com/MichaelWeissDEV/tmux-config) | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **Ghostty (`ghostty-config`)** | [MichaelWeissDEV/ghostty-config](https://github.com/MichaelWeissDEV/ghostty-config) | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **Kitty (`kitty-config`)** | [MichaelWeissDEV/kittiy-config](https://github.com/MichaelWeissDEV/kittiy-config) | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **Vim (`vim-config`)** | [MichaelWeissDEV/vim-config](https://github.com/MichaelWeissDEV/vim-config) | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |
