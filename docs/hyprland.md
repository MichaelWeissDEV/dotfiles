# Hyprland Desktop Environment

Hyprland serves as the primary Wayland tiling compositor in this setup. It is configured specifically for **instant reaction speeds**, **multi-monitor workspace agility**, and **seamless window recall** across screens.

---

## Design Philosophy

- ⚡ **Instant Reactions**: Window animations, border fades, and transition latencies are tuned for maximum speed and zero perceptual lag.
- 📺 **Zero Lost Windows**: You can jump back to your last active window, cycle through all open windows across monitors, or assign persistent window slots with single keychords.
- 🎨 **Catppuccin Mocha**: Active windows are bordered in Pastel Blue (`#89b4fa`), inactive windows in subtle Slate (`#313244`).
- 🖥️ **TTY Launch**: No display manager overhead (e.g. GDM or SDDM). The system boots directly to a lightweight Linux TTY; run `start-hyprland` to enter your graphical session.

---

## Quick Navigation & Window Switching

Cross-monitor and cross-workspace window management is built directly into Hyprland keybindings and the helper script `windowswitcher.sh`.

### Instant Window Jump (Ping-Pong Switch)

| Keybinding | Action |
| :--- | :--- |
| <kbd>Alt</kbd> + <kbd>Tab</kbd> *(or <kbd>Super</kbd> + <kbd>Tab</kbd>, <kbd>Super</kbd> + <kbd>BackSpace</kbd>)* | **Jump immediately to the previous active window** anywhere across all monitors and workspaces. Pressing it again jumps right back, enabling effortless two-window ping-pong workflows. |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>Tab</kbd> *(or <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Tab</kbd>)* | **Cycle through all open windows** across all monitors and workspaces in round-robin fashion. |
| <kbd>Super</kbd> + <kbd>^</kbd> *(key below Escape)* | **Cycle between windows of the current application** (e.g., jump between multiple Kitty terminal windows or Firefox profiles across monitors). |

### Window Slots (Pinning & Instant Recall)

Assign critical windows (such as your terminal IDE, database client, documentation browser, or chat client) to dedicated numeric or function key slots:

| Action | Keybinding |
| :--- | :--- |
| **Save active window to Slot 1..10** | <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>1..0</kbd> |
| **Save active window to Slot F1..F4** | <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>F1..F4</kbd> |
| **Instant Jump to Slot 1..10** | <kbd>Super</kbd> + <kbd>1..0</kbd> *(if slot is occupied)* |
| **Instant Jump to Slot F1..F4** | <kbd>Super</kbd> + <kbd>F1..F4</kbd> *(if slot is occupied)* |
| **Clear Slot assignment** | <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>1..0</kbd> *(or <kbd>F1..F4</kbd>)* |

Slots persist across workspace shifts and automatically track the window even if it is moved to another physical monitor.

### Interactive Fuzzy Window Switcher

Pressing <kbd>Super</kbd> + <kbd>G</kbd> or <kbd>Super</kbd> + <kbd>#</kbd> invokes the **Window Switcher** powered by `fuzzel`:

```bash
~/.config/hypr/windowswitcher.sh
```

- Displays all open windows across all screens sorted by recency.
- The most recently active window is placed on top; hitting <kbd>Enter</kbd> immediately focuses it.
- Shows window title, application class, assigned slot number, and monitor name.
- Fuzzy typing allows jumping directly to any window by entering its title or class name (e.g. `slack`, `term`, `docs`).

---

## Monitor Navigation

| Keybinding | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>&lt;</kbd> | Focus previous physical monitor |
| <kbd>Super</kbd> + <kbd>o</kbd> | Focus next physical monitor |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>&lt;</kbd> | Move active window to previous physical monitor |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>o</kbd> | Move active window to next physical monitor |

---

## Window Tiling & Layout Controls

| Keybinding | Action |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>c</kbd> *(or <kbd>Super</kbd> + <kbd>w</kbd>)* | Close active window |
| <kbd>Super</kbd> + <kbd>v</kbd> | Toggle floating mode for active window |
| <kbd>Super</kbd> + <kbd>f</kbd> | Toggle full screen |
| <kbd>Super</kbd> + <kbd>p</kbd> | Pin floating window (stays visible on all workspaces) |
| <kbd>Super</kbd> + <kbd>h/j/k/l</kbd> *(or Arrow Keys)* | Move focus directionally (Left / Down / Up / Right) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>h/j/k/l</kbd> | Swap window position directionally |

---

## Application Launchers & System Controls

| Keybinding | Target |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Space</kbd> *(or <kbd>Super</kbd> + <kbd>d</kbd>)* | Open **Fuzzel** application launcher |
| <kbd>Super</kbd> + <kbd>Return</kbd> *(or <kbd>Super</kbd> + <kbd>q</kbd>)* | Open default terminal (**Kitty**) |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Return</kbd> | Open terminal attached to persistent **tmux** session |
| <kbd>Super</kbd> + <kbd>b</kbd> | Launch web browser (**Firefox**) |
| <kbd>Super</kbd> + <kbd>e</kbd> | Open GUI file manager (**PCManFM**) |
| <kbd>Super</kbd> + <kbd>y</kbd> | Open TUI file manager (**Yazi**) |
| <kbd>Super</kbd> + <kbd>l</kbd> | Lock session (**hyprlock**) |
| <kbd>Super</kbd> + <kbd>Escape</kbd> | Open system power menu |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>w</kbd> | Open wallpaper switcher |
| <kbd>Print</kbd> | Capture full screen screenshot to clipboard |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>s</kbd> *(or <kbd>Super</kbd> + <kbd>Print</kbd>)* | Capture selected screen region |

---

## Wallpaper Management (`hyprpaper`)

The custom wallpaper system (`wallpaper` CLI and daemon) manages desktop backgrounds through `hyprpaper`:

```bash
# Set global wallpaper on all monitors:
wallpaper set ~/git/dotfiles/pictures/mountain.png

# Set independent wallpaper on a specific monitor:
wallpaper set ~/git/dotfiles/pictures/abstract.png --monitor DP-1

# Interactive picker:
wallpaper
```
- Wallpapers live in `~/git/dotfiles/pictures`, a private Git repository excluded from the public dotfiles repository via `.gitignore` for copyright reasons. Set it up with `scripts/install-wallpapers.sh <git-url>`.
- Saved monitor configurations are stored in `~/.local/state/wallpaper/state` and restored automatically upon login.
- Supported directories can be configured in `~/.config/wallpaper/wallpaper.conf`.
