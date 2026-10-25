# Hyprland Desktop Environment & Keybindings

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

Hyprland (`~/.config/hypr/hyprland.lua`) serves as the primary Wayland tiling compositor in the [`arch-dotfiles`](https://arch-dotfiles.readthedocs.io/en/latest/) ecosystem. It is engineered for **instant reaction speeds**, **maximum screen real estate**, **multi-monitor workspace agility**, and **seamless cross-monitor window recall**.

---

## Design Philosophy

- ⚡ **Instant Reactions**: Animations, shadows, and blur are intentionally disabled (`animations.enabled = false`, `blur.enabled = false`, `shadow.enabled = false`) for zero perceptual latency and minimal GPU overhead.
- 📐 **Maximum Screen Space**: Zero inner/outer gaps (`gaps_in = 0`, `gaps_out = 0`), sharp unrounded corners (`rounding = 0`), and a crisp `1px` border (`#89b4fa` Pastel Blue when active, `#313244` Surface0 when inactive).
- 📺 **Zero Lost Windows**: Jump back to your last active window across any monitor (`ALT + Tab`), cycle all open windows (`ALT + SHIFT + Tab`), filter via Fuzzel (`SUPER + G`), or pin critical windows to persistent cross-monitor slots (`1..10` and `F1..F4`).
- 🖥️ **TTY Launch**: No display manager bloat. Log into the Linux TTY and start the graphical session with `start-hyprland`.

---

## Application Launchers & System Controls

The primary modifier key (`SUPER`) is the **Windows / Super key**.

| Keybinding | Command / Script | Action |
| :--- | :--- | :--- |
| <kbd>Super</kbd> + <kbd>Space</kbd> *(or <kbd>Alt</kbd> + <kbd>Space</kbd>, <kbd>Super</kbd> + <kbd>D</kbd> / <kbd>R</kbd> / <kbd>A</kbd>)* | `pkill -x fuzzel \|\| fuzzel` | Toggle **Fuzzel** application launcher |
| <kbd>Super</kbd> + <kbd>Return</kbd> *(or <kbd>Super</kbd> + <kbd>Q</kbd>)* | `kitty` | Open default terminal ([Kitty](https://kitty-config.readthedocs.io/en/latest/)) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Return</kbd> | `kitty -e tmux new-session -A -s main` | Open terminal attached to persistent [tmux](https://tmux-config.readthedocs.io/en/latest/) session `main` |
| <kbd>Super</kbd> + <kbd>B</kbd> | `firefox` | Launch web browser (**Firefox**) |
| <kbd>Super</kbd> + <kbd>E</kbd> | `pcmanfm` | Open GUI file manager (**PCManFM** in Catppuccin Mocha GTK theme) |
| <kbd>Super</kbd> + <kbd>Y</kbd> | `kitty -e yazi` | Open TUI file manager (**Yazi** in Catppuccin Mocha flavor) |
| <kbd>Super</kbd> + <kbd>L</kbd> | `hyprlock` | Lock screen immediately |
| <kbd>Super</kbd> + <kbd>Escape</kbd> | `~/.config/hypr/powermenu.sh` | Open top-right Fuzzel Power Menu (Shutdown, Reboot, Suspend, Lock, Logout) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> | `killall -SIGUSR2 waybar \|\| ...` | Reload or restart **Waybar** |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd> | `~/.config/wallpaper/wallpaper.sh tui` | Open interactive multi-monitor **Wallpaper TUI** (`wallpaper`) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> *(or <kbd>Super</kbd> + <kbd>M</kbd>)* | `hl.dsp.exit()` | Exit Hyprland session back to TTY |

---

## Cross-Monitor Window Switching & Pinning Slots (`1–10` / `F1–F4`)

All window switching functions in `hyprland.lua` operate **globally across all connected monitors and workspaces** (including automatically revealing windows hidden in the special scratchpad workspace).

### 1. Instant Ping-Pong & Cycling

| Keybinding | Function | Action |
| :--- | :--- | :--- |
| <kbd>Alt</kbd> + <kbd>Tab</kbd> *(or <kbd>Super</kbd> + <kbd>Tab</kbd>, <kbd>Super</kbd> + <kbd>BackSpace</kbd>)* | `focus_last_window()` | **Jump immediately to the last active window** across any monitor or workspace. Pressing it again jumps right back (ping-pong switch). |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>Tab</kbd> *(or <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Tab</kbd>)* | `cycle_all_windows(1)` | **Cycle through all open windows** across all monitors and workspaces (sorted spatially left-to-right, top-to-bottom). |
| <kbd>Super</kbd> + <kbd>^</kbd> *(or <kbd>Super</kbd> + <kbd>`</kbd>, key below Escape)* | `cycle_same_class()` | **Cycle through windows of the same application** across all monitors (e.g. all Kitty terminals or Firefox windows). |
| <kbd>Super</kbd> + <kbd>G</kbd> *(or <kbd>Super</kbd> + <kbd>#</kbd>)* | `~/.config/hypr/windowswitcher.sh` | **Interactive Fuzzel Window & Slot Switcher**: Lists all open windows sorted by focus history (most recent window first -> press <kbd>Enter</kbd> to jump immediately, or type to filter by app, title, monitor, or `Pos 1..9`). |

### 2. Window Pinning Slots (`1..10` and `F1..F4`)

Pin critical windows (IDE, browser, docs, terminal, chat) to persistent slots and jump to them from any monitor:

| Keybinding | Function | Action |
| :--- | :--- | :--- |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>1..9, 0</kbd> | `save_window_slot(1..10)` | **Pin/save active window to Slot `1..10`** (shows a desktop notification and tags the window with `slot_<n>`). |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>1..9, 0</kbd> | `jump_window_slot(1..10)` | **Jump to Slot `1..10`** across any monitor/workspace:<br>• If a window is pinned to slot `<n>`, focuses it immediately *(pressing the same chord again while already in that window jumps back to your previous window!)*.<br>• If no window was manually pinned to slot `<n>`, jumps to the `<n>`-th open window spatially. |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>F1..F4</kbd> *(or <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>F1..F4</kbd>)* | `save_window_slot(1..4)` | **Pin/save active window to Quick Slot `1..4`**. |
| <kbd>Super</kbd> + <kbd>F1..F4</kbd> | `jump_window_slot(1..4)` | **Single-chord Quick Jump to Slot `1..4`** (or back to previous window if already focused). |

---

## Multi-Monitor Controls

| Keybinding | Function | Action |
| :--- | :--- | :--- |
| <kbd>Super</kbd> + <kbd>O</kbd> *(or <kbd>Super</kbd> + <kbd>&lt;</kbd>)* | `focus_next_monitor(1)` | Focus the next / other physical monitor |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> *(or <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>&lt;</kbd>)* | `move_window_to_next_monitor()` | Move active window to the next physical monitor and focus it |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>O</kbd> | `swap_monitors_workspaces()` | Swap the active workspaces between the two monitors |

---

## Workspaces (Dynamic / Infinite Workspaces)

Workspaces are created dynamically as needed:

| Keybinding | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>1..9, 0</kbd> | Switch directly to workspace `1..10` (creates it if not yet active) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>1..9, 0</kbd> | Move active window to workspace `1..10` |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>1..9, 0</kbd> | Switch to workspace/monitor `1..10` **only if it already exists** (`focus_existing_screen`, avoids creating empty workspaces) |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>←</kbd> / <kbd>→</kbd> | Switch one workspace to the left (`r-1`) / right (`r+1`) |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd> / <kbd>→</kbd> | Move active window one workspace to the left (`r-1`) / right (`r+1`) |
| <kbd>Super</kbd> + <kbd>.</kbd> *(or <kbd>Super</kbd> + <kbd>PageDown</kbd>)* | Switch to next workspace (`r+1`, unbounded) |
| <kbd>Super</kbd> + <kbd>,</kbd> *(or <kbd>Super</kbd> + <kbd>PageUp</kbd>)* | Switch to previous workspace (`r-1`) |
| <kbd>Super</kbd> + <kbd>N</kbd> | Jump to the next completely empty workspace (`empty`) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>.</kbd> / <kbd>,</kbd> | Move active window to next (`r+1`) / previous (`r-1`) workspace |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>N</kbd> | Move active window to the next completely empty workspace |
| <kbd>Super</kbd> + <kbd>Mouse Wheel Up / Down</kbd> | Cycle through workspaces (`r-1` / `r+1`) |
| `3-Finger Horizontal Swipe` *(Touchpad)* | Swipe horizontally between workspaces |
| <kbd>Super</kbd> + <kbd>S</kbd> | Toggle special scratchpad workspace (`special:magic`) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> | Move active window into the scratchpad (`special:magic`) |

---

## Window Tiling, Floating & Resizing

| Keybinding | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>C</kbd> *(or <kbd>Super</kbd> + <kbd>W</kbd>)* | Close active window |
| <kbd>Super</kbd> + <kbd>F</kbd> | Toggle true fullscreen |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> | Toggle maximized state (Waybar remains visible) |
| <kbd>Super</kbd> + <kbd>V</kbd> | Toggle floating mode for active window |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>C</kbd> | Center floating window on screen |
| <kbd>Super</kbd> + <kbd>T</kbd> | Toggle dwindle split direction (Horizontal / Vertical) |
| <kbd>Super</kbd> + <kbd>P</kbd> | Toggle pseudo-tiling for active window |
| <kbd>Super</kbd> + <kbd>←</kbd> / <kbd>→</kbd> / <kbd>↑</kbd> / <kbd>↓</kbd> | Move focus directionally (crosses onto adjacent monitors automatically at screen edges) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd> / <kbd>→</kbd> / <kbd>↑</kbd> / <kbd>↓</kbd> | Move/swap active window directionally |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>←</kbd> / <kbd>→</kbd> / <kbd>↑</kbd> / <kbd>↓</kbd> | Resize active window in `40px` increments (repeatable) |
| <kbd>Super</kbd> + `Left Mouse Drag` | Move window with mouse |
| <kbd>Super</kbd> + `Right Mouse Drag` | Resize window with mouse (or drag window borders directly) |

---

## Screenshots, Audio & Brightness

| Keybinding | Command | Action |
| :--- | :--- | :--- |
| <kbd>Print</kbd> | `grim - \| tee ~/Downloads/screenshot-*.png \| wl-copy` | Capture full screen screenshot to `~/Downloads/` and Wayland clipboard |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> | `grim -g "$(slurp)" - \| tee ~/Downloads/screenshot-*.png \| wl-copy` | Select region with `slurp`, save to `~/Downloads/` and copy to clipboard |
| `XF86AudioRaiseVolume` / `LowerVolume` | `wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+/-` | Increase / decrease volume in 5% steps (capped at 100%) |
| `XF86AudioMute` / `XF86AudioMicMute` | `wpctl set-mute ... toggle` | Toggle speaker mute / microphone mute |
| `XF86MonBrightnessUp` / `Down` | `brightnessctl -e4 -n2 set 5%+/-` | Increase / decrease screen brightness in 5% steps |

---

## Wallpaper Management (`hyprpaper` & `wallpaper` CLI)

Desktop backgrounds are managed through `hyprpaper` and the custom `wallpaper` script (`~/.config/wallpaper/wallpaper.sh`, linked to `~/.local/bin/wallpaper` and aliased to `wp`):

```bash
# Open interactive Fuzzel picker (choose All/Default or specific monitor, then image):
wallpaper

# List all wallpapers (★ = Default, ● = Monitor Override):
wallpaper list

# Set global default wallpaper (for all monitors without an override):
wallpaper set forest.png

# Set an independent override wallpaper on a specific monitor:
wallpaper set ocean.png --monitor DP-1

# Set the same wallpaper everywhere and clear all overrides:
wallpaper set city.png --all

# Clear a monitor's override so it reverts to the global default:
wallpaper monitor DP-1 default

# Add a new wallpaper image into ~/git/dotfiles/pictures and apply it:
wallpaper add ~/Downloads/mountain.jpg --set
```

- Wallpapers reside in `~/git/dotfiles/pictures`, a private Git repository excluded via `.gitignore` (copyright) and managed via `arch-dot wallpapers <git-url>` or `arch-dot wallpapers --update`.
- Persistent monitor state is stored in `~/.local/state/wallpaper/state` (outside the Git worktree) and automatically restored on login and monitor hot-plug.

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
