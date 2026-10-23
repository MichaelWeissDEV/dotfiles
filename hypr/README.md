<div align="center">

# Hyprland Configuration — Catppuccin Mocha

**Instant reaction speed · Maximum screen real estate · Cross-monitor window slots (`1–10` / `F1–F4`)**

Arch Linux · Hyprland · Waybar · Fuzzel · Hyprpaper · Hyprlock

[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Hyprland Docs](https://img.shields.io/badge/docs-Hyprland%20Guide-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Hyprland Guide](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/) ·
[Waybar Guide](https://arch-dotfiles.readthedocs.io/en/latest/waybar/) ·
[Shell & CLI (`adot` / `arch-dot`)](https://arch-dotfiles.readthedocs.io/en/latest/shell/)

</div>

---

## Overview

This Hyprland configuration (`~/.config/hypr/hyprland.lua`) is engineered for **instant reaction times** (zero animation lag, zero blur overhead), **maximum screen real estate** (`gaps = 0`, `rounding = 0`, `border_size = 1`), and the official **Catppuccin Mocha** pastel palette.

While pre-configured for **Arch Linux** via the central [`arch-dotfiles`](https://arch-dotfiles.readthedocs.io/en/latest/) CLI program (`adot install` / `adot update` — also available as `arch-dot` or `arch-dotfiles`), it can be easily adapted to any Linux distribution running Wayland and Hyprland.

---

## Starting from TTY

By design, the system does **not** boot into a graphical display manager (such as GDM or SDDM), avoiding unnecessary background services. After logging into the standard Linux **TTY**, launch Hyprland manually:

```bash
start-hyprland
```
*(Alternatively, running `Hyprland` directly also works.)*

---

## Application Launcher & Power Menu

- **Keyboard Application Launcher (`fuzzel`)**:
  - Press `SUPER + Space` *(or `ALT + Space`, `SUPER + D`, `SUPER + R`, `SUPER + A`)* to open the Catppuccin Mocha styled **Fuzzel** launcher.
  - There is intentionally no launcher icon in Waybar; launching is purely keyboard-driven.
  - **Launch apps**: Type to filter, select with arrow keys, and press `Enter`.
  - **Execute arbitrary shell commands**: Type a command and press `SHIFT + Enter`.
  - **Wi-Fi / Network**: Accessible directly via the *"WLAN & Netzwerk (nmtui)"* launcher entry or right-clicking the network module in Waybar.
- **Power Menu (Top-Right `󰐥` in Waybar)**:
  - **Left-click on `󰐥`**: Opens a compact GTK dropdown menu (`waybar/power_menu.xml`) right below the bar:
    - `󰐥  Herunterfahren` (`systemctl poweroff`)
    - `󰜉  Neu starten` (`systemctl reboot`)
    - `󰤄  Standby` (`systemctl suspend`)
    - `󰌾  Bildschirm sperren` (`hyprlock`)
    - `󰍃  Abmelden (TTY)` (`hyprctl dispatch exit`)
  - **Right-click on `󰐥`** *(or press `SUPER + Escape`)*: Opens the keyboard-driven Fuzzel power menu (`~/.config/hypr/powermenu.sh`) anchored at the top-right corner.

---

## Complete Keybindings Reference (`hyprland.lua`)

The primary modifier key (`SUPER`) is the **Windows / Super key**.

### 1. Applications & System Controls

| Keybinding | Action |
| :--- | :--- |
| `SUPER + Space` *(or `ALT + Space`, `SUPER + D`, `SUPER + R`, `SUPER + A`)* | Open / close application launcher (`fuzzel`) |
| `SUPER + Return` *(or `SUPER + Q`)* | Open terminal (`kitty` with `zsh` + Oh My Zsh, `0.90` opacity) |
| `SUPER + SHIFT + Return` | Open terminal directly attached to persistent **tmux** session (`tmux new-session -A -s main`) |
| `SUPER + E` | Open **GUI file manager** (`pcmanfm`, Catppuccin Mocha GTK theme) |
| `SUPER + Y` | Open **TUI file manager** (`yazi`, official Catppuccin Mocha flavor) |
| `SUPER + B` | Open web browser (`firefox`) |
| `SUPER + L` | Lock screen (`hyprlock`) |
| `SUPER + Escape` | Open top-right Fuzzel Power Menu (`powermenu.sh`) |
| `SUPER + SHIFT + B` | Reload / restart Waybar |
| `SUPER + SHIFT + W` | Open interactive Wallpaper TUI (`wallpaper` — global default or per-monitor) |
| `SUPER + SHIFT + E` *(or `SUPER + M`)* | Exit Hyprland immediately (return to TTY) |

### 2. Cross-Monitor Window Switching, Last Window & Pinning Slots (`1–10` / `F1–F4`)

Switch instantaneously between applications, ping-pong back to the previously focused window, or pin your most important windows to dedicated **Jump Slots (`1–10` and `F1–F4`)** — working **seamlessly across all monitors and workspaces**:

| Keybinding | Action |
| :--- | :--- |
| **`ALT + Tab`** *(or `SUPER + Tab` / `SUPER + BackSpace`)* | **Jump immediately to the last active window** — regardless of which monitor or workspace it is on. Pressing it again jumps right back (ideal ping-pong workflow between two apps!). |
| **`ALT + SHIFT + Tab`** *(or `SUPER + SHIFT + Tab`)* | Cycle through **all open windows** across all monitors and workspaces (sorted spatially left-to-right). |
| **`SUPER + ^`** *(or `SUPER + grave`, key below `Esc`)* | Cycle through all windows of the **same application class** across all monitors (e.g., all open terminal or browser windows). |
| **`SUPER + G`** *(or `SUPER + #`)* | Open interactive **Window & Slot Switcher (`windowswitcher.sh` via `fuzzel`)**: Lists all open windows across all monitors & workspaces. The **last active window** is placed at position 1 so pressing `Enter` switches to it immediately, or type to filter by title, app, or slot (`Pos 1..9`). |
| **`SUPER + ALT + 1..9, 0`** | **Jump directly to Window Slot `1..10`** (across all monitors & workspaces!):<br>• If a window was manually saved to slot `<num>`, Hyprland jumps directly to it *(pressing the same key again while focused on that window jumps back to your previous window!)*.<br>• If nothing was manually saved to slot `<num>` yet, it automatically jumps to the `<num>`-th open window (sorted spatially left-to-right across all monitors). |
| **`SUPER + CTRL + 1..9, 0`** | **Pin/save the currently focused window to Slot `1..10`** (displays a brief notification and persists across workspace/monitor changes). |
| **`SUPER + F1..F4`** | **Single-chord Quick Jump to Slot `1..4`** (jumps immediately to slot `1..4` or back to the previous window). |
| **`SUPER + CTRL + F1..F4`** *(or `SUPER + SHIFT + F1..F4`)* | Pin/save the currently focused window to **Quick Slot `1..4`**. |
| **`SUPER + O`** *(or `SUPER + <`)* | Focus the **next / other physical monitor** immediately. |
| **`SUPER + SHIFT + O`** *(or `SUPER + SHIFT + <`)* | Move the active window to the **next / other physical monitor** and focus it there. |
| **`SUPER + CTRL + O`** | **Swap** the active workspaces between monitors (`swap_monitors`). |

### 3. Workspaces & Monitors (Dynamic / Infinite Workspaces)

Workspaces are **not restricted to a fixed static list**. Waybar only displays active/occupied workspaces on the top-left.

| Keybinding | Action |
| :--- | :--- |
| `CTRL + ALT + Left / Right` | Switch one workspace to the **left** (`r-1`) or **right** (`r+1`) |
| `CTRL + ALT + 1..9, 0` | Switch to workspace/monitor `<num>` **only if it already exists** (checks active workspaces and connected monitors without creating empty intermediate workspaces) |
| `CTRL + ALT + SHIFT + Left / Right` | Move active window one workspace to the left (`r-1`) / right (`r+1`) |
| `SUPER + 1..9, 0` | Switch directly to workspace `1..10` (creates it if not yet active) |
| `SUPER + SHIFT + 1..9, 0` | Move active window to workspace `1..10` |
| `SUPER + .` *(Period)* or `SUPER + PageDown` | Next workspace (`r+1`, unbounded) |
| `SUPER + ,` *(Comma)* or `SUPER + PageUp` | Previous workspace (`r-1`) |
| `SUPER + N` | Jump to the next completely empty workspace (`empty`) |
| `SUPER + SHIFT + .` / `SUPER + SHIFT + ,` | Move active window to next (`r+1`) / previous (`r-1`) workspace |
| `SUPER + SHIFT + N` | Move active window to the next completely empty workspace |
| `SUPER + Mouse Wheel Up / Down` | Scroll through workspaces (`r-1` / `r+1`) |
| `3-Finger Horizontal Swipe (Touchpad)` | Swipe horizontally between workspaces |
| `SUPER + S` | Toggle special scratchpad workspace (`special:magic`) |
| `SUPER + SHIFT + S` | Move active window into the scratchpad (`special:magic`) |

### 4. Window Management & Resizing

| Keybinding | Action |
| :--- | :--- |
| `SUPER + C` *(or `SUPER + W`)* | Close active window |
| `SUPER + F` | Toggle true fullscreen |
| `SUPER + SHIFT + F` | Toggle maximized state (Waybar remains visible) |
| `SUPER + V` | Toggle floating mode for active window |
| `SUPER + CTRL + C` | Center floating window on screen |
| `SUPER + T` | Toggle split direction (Horizontal / Vertical) |
| `SUPER + P` | Toggle pseudo-tiling |
| `SUPER + Arrow Keys (Left/Right/Up/Down)` | Move focus directionally between windows *(automatically crosses over to neighboring monitors at screen edges!)* |
| `SUPER + SHIFT + Arrow Keys (Left/Right/Up/Down)` | Move/swap active window directionally |
| `SUPER + CTRL + Arrow Keys (Left/Right/Up/Down)` | Resize active window in 40px increments (repeatable) |
| `SUPER + Left Mouse Drag` | Move window with mouse |
| `SUPER + Right Mouse Drag` | Resize window with mouse *(or drag window borders directly)* |

### 5. Screenshots, Audio & Brightness

| Keybinding | Action |
| :--- | :--- |
| `Print` | Capture full screen screenshot (saved to `~/Downloads/` and copied to Wayland clipboard via `wl-copy`) |
| `SUPER + SHIFT + P` | Select screen region with `slurp` and capture screenshot (saved to `~/Downloads/` + clipboard) |
| `XF86AudioRaiseVolume` / `LowerVolume` / `Mute` | Adjust volume in 5% steps / toggle mute (`wpctl`) |
| `XF86AudioMicMute` | Toggle microphone mute (`wpctl`) |
| `XF86MonBrightnessUp` / `Down` | Adjust screen brightness in 5% steps (`brightnessctl`) |

---

## Multi-Monitor Wallpapers (`wallpaper`)

Wallpapers are managed via **hyprpaper** and the custom `wallpaper` CLI/TUI (`~/.config/wallpaper/wallpaper.sh`), supporting both a **global default** and **per-monitor overrides**. Saved state is automatically restored on Hyprland startup and when hot-plugging monitors.

| Action | Command / Shortcut |
| :--- | :--- |
| Open interactive Fuzzel TUI | `SUPER + SHIFT + W` or `wallpaper` |
| List available wallpapers | `wallpaper list` |
| Set default wallpaper | `wallpaper set forest.png` |
| Set per-monitor override | `wallpaper set ocean.png --monitor DP-1` |
| Set everywhere & clear overrides | `wallpaper set city.png --all` |
| Remove monitor override | `wallpaper monitor DP-1 default` |
| Show active assignments | `wallpaper current` |
| Add image to library & apply | `wallpaper add ~/Downloads/pic.jpg --set` |

Full details: [`../wallpaper/README.md`](../wallpaper/README.md).

---

## Shell (`zsh`) & Multiplexer (`tmux`) Integration

- **Zsh (`~/.zshrc` & `~/.config/zsh/aliases.zsh`)**:
  - Default login shell across `kitty`, `ghostty`, and `foot`.
  - Active Oh My Zsh plugins: `git`, `sudo` (`Esc` `Esc` prepends `sudo`), `zsh-autosuggestions`, and `zsh-syntax-highlighting` (styled in Catppuccin Mocha).
  - Central dotfiles CLI (`adot` / `arch-dot` / `arch-dotfiles`): `adot update` (or `adot update <subtree>`), `adot status`, `adot list`, `adot keys`, `adot commands`, `adot scripts`.
  - Editor & navigation helpers: `j <dir>` / `ji` (smart directory **jump** powered under the hood by `zoxide`, also aliased as `z` / `zi`), `y` (`yazi` with auto-`cd` on exit), `nv` (`nvim`), `v` (`vim`), `fznv` (FZF -> Neovim), `fzv` (FZF -> Vim), `tm` / `tn` / `ta` / `tl` (tmux session helpers).
- **tmux (`~/.config/tmux/tmux.conf`)**:
  - Embedded via [`tmux-config`](https://tmux-config.readthedocs.io/en/latest/).
  - Press `Ctrl+b H` inside tmux to open the interactive **Key Explorer** popup.

---

## Color Palette (Official Catppuccin Mocha — Pastel Theme)

- **Base (Background)**: `#1e1e2e`
- **Mantle / Crust**: `#181825` / `#11111b`
- **Surface0 / Surface1 (Inactive Borders & Selection)**: `#313244` / `#45475a`
- **Text / Subtext**: `#cdd6f4` / `#a6adc8`
- **Pastel Blue (Primary Accent / Active Focus Border)**: `#89b4fa`
- **Pastel Teal & Sapphire**: `#94e2d5` / `#74c7ec`
- **Pastel Green**: `#a6e3a1`
- **Pastel Lavender & Mauve**: `#b4befe` / `#cba6f7`
- **Pastel Red & Peach (Warnings / Urgent)**: `#f38ba8` / `#fab387`

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
