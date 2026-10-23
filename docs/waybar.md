# Waybar Status Bar

Waybar provides the top desktop panel for the Hyprland session, offering at-a-glance telemetry, workspace state, audio controls, and an integrated system power menu.

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

> The application launcher and wallpaper selector are intentionally **not** in Waybar. Start the launcher with <kbd>Super</kbd> + <kbd>Space</kbd> (or <kbd>Super</kbd> + <kbd>D</kbd>) and the wallpaper TUI with <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd> or the `wallpaper` command.

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
   Launches the keyboard-driven menu (`powermenu.sh`) powered by `fuzzel`, allowing quick navigation with arrow keys and <kbd>Enter</kbd>. (Also accessible globally via <kbd>Super</kbd> + <kbd>Escape</kbd>).

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

```text
~/.config/waybar/
├── config.jsonc           # Module definitions, formatting, and update intervals
├── style.css              # Catppuccin Mocha stylesheet with rounded pill margins
└── power_menu.xml         # GTK menu definition for the power dropdown button
```
