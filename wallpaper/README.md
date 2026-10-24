<div align="center">

# Wallpaper Switcher — Catppuccin Mocha

**Multi-monitor wallpaper manager for Hyprland (`hyprpaper`) with Fuzzel TUI & CLI.**

Global Default · Per-Monitor Overrides · Automatic Hot-Plug Restore · XDG State Cleanliness

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Hyprland Guide](https://img.shields.io/badge/docs-Hyprland%20%26%20Wallpapers-89b4fa)](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/#wallpaper-management-hyprpaper)
[![Dotfiles Hub](https://img.shields.io/badge/ecosystem-arch--dotfiles-1793D1?logo=arch-linux&logoColor=white)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![Platform: Arch Linux](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Hyprland & Wallpaper Guide](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/#wallpaper-management-hyprpaper) ·
[Installation Guide](https://arch-dotfiles.readthedocs.io/en/latest/installation/) ·
[Configuration (`wallpaper.conf`)](wallpaper.conf) ·
[Executable (`wallpaper.sh`)](wallpaper.sh)

</div>

---

## Overview

`wallpaper` ([`wallpaper.sh`](wallpaper.sh), linked to `~/.local/bin/wallpaper`) manages desktop backgrounds under Hyprland via **hyprpaper** — supporting both a **global default for all screens** and **independent per-monitor overrides** (e.g., for secondary or tertiary displays).

Wallpapers are loaded from the private library at `~/git/dotfiles/pictures` (and any additional directories configured in [`wallpaper.conf`](wallpaper.conf)). Because `pictures/` is excluded from the public repository via `.gitignore` for copyright reasons, it is managed as a standalone private Git repository via `adot wallpapers` (or `arch-dot wallpapers`). Subdirectories are scanned recursively.

While built for the **Arch Linux + Hyprland** dotfiles setup, `wallpaper` works on any Linux distribution running Hyprland, `hyprpaper`, `jq`, and `fuzzel`.

---

## Quick Start

```bash
# Open interactive Fuzzel TUI: first choose target (all/default or specific monitor), then pick wallpaper
wallpaper
# (or press SUPER + SHIFT + W in Hyprland)

# List available wallpapers (★ = Default, ● = Monitor Override)
wallpaper list

# Set global default for all monitors that do not have a custom override
wallpaper set forest.png

# Set a dedicated override wallpaper for a specific monitor (e.g. DP-1)
wallpaper set ocean.png --monitor DP-1

# Set the same wallpaper everywhere and clear all monitor overrides
wallpaper set city.png --all

# Remove a monitor's override (reverts that monitor to the global default)
wallpaper monitor DP-1 default

# Show current assignment and active wallpapers per monitor
wallpaper current
```

When Hyprland starts (or when a new monitor is hot-plugged), the saved assignment in `~/.local/state/wallpaper/state` is applied automatically.

---

## CLI Command Reference

| Command | Description |
| :--- | :--- |
| `wallpaper` *(or `wallpaper tui`)* | Open interactive Fuzzel TUI (select target monitor + wallpaper) |
| `wallpaper list [--monitor MON] [--plain]` | List discovered wallpapers (`--plain` prints filenames only) |
| `wallpaper set <name\|path> [--monitor MON \| --all]` | Set global default or per-monitor override |
| `wallpaper default [<name\|path>]` | Show or set the global default wallpaper |
| `wallpaper monitor <MON> [<name\|path>\|default]` | Show, set, or clear the override for monitor `<MON>` |
| `wallpaper clear <MON> \| --all` | Clear override for `<MON>` or clear all monitor overrides |
| `wallpaper current` | Show saved state and currently active wallpapers per monitor |
| `wallpaper next` / `wallpaper prev` | Cycle to next / previous wallpaper |
| `wallpaper random [--monitor MON \| --all]` | Apply a random wallpaper from the library |
| `wallpaper apply [--quiet] [--monitor MON]` | Re-apply saved wallpaper assignments to running `hyprpaper` |
| `wallpaper reload` | Restart `hyprpaper` daemon and re-apply saved state |
| `wallpaper dirs` | Show configured wallpaper search directories, config file, and state |
| `wallpaper add <file>... [--move] [--set]` | Copy (or `--move`) image(s) into the wallpaper library (`--set` applies immediately) |
| `wallpaper open` | Open the wallpaper directory in the file manager |
| `wallpaper doctor` | Diagnose dependencies (`hyprpaper`, `jq`, `fuzzel`), monitors, and state |

### Target Semantics

- **Default (`wallpaper set X` or `wallpaper default X`)**: Applies to all monitors that do not have an explicit per-monitor override.
- **Monitor Override (`wallpaper set X --monitor DP-1`)**: Applies exclusively to `DP-1` and remains pinned even when the global default changes.
- **`--all` (`wallpaper set X --all`)**: Sets the global default to `X` and removes all per-monitor overrides so every screen shows `X`.

---

## Private Wallpaper Repository (`pictures/`)

Wallpaper images are stored in:

```text
~/git/dotfiles/pictures/
```

This directory is listed in `.gitignore` so copyrighted images are never committed to the public dotfiles repository. It is intentionally cloned as a standalone Git repository rather than a Git submodule so no private repository URL is leaked in `.gitmodules`.

### Initial Setup & Updating

```bash
# Clone private wallpaper repository (one-time):
adot wallpapers <git-url>
# (also available as: arch-dot wallpapers <git-url>)

# Update existing wallpaper repository:
adot update wallpapers
# (or automatically as part of: adot update)
```

> **Caution:** Because `pictures/` is gitignored, running `git clean -fdx` in the root dotfiles repository would delete `pictures/`. Always commit and push any new wallpapers inside `~/git/dotfiles/pictures` before running a force-clean.

---

## Adding Your Own Wallpapers

Drop images directly into `~/git/dotfiles/pictures/` (subdirectories are scanned recursively) or import them via the CLI:

```bash
# Copy image into ~/git/dotfiles/pictures/
wallpaper add ~/Downloads/my-wallpaper.jpg

# Copy and immediately set as global default
wallpaper add ~/Downloads/my-wallpaper.jpg --set

# Move instead of copy
wallpaper add ~/Downloads/my-wallpaper.jpg --move
```

New images appear immediately in `wallpaper` (TUI) and `wallpaper list` without restarting Hyprland or `hyprpaper`.

### Configuring Additional Directories (`wallpaper.conf`)

You can configure extra directories or glob patterns in `~/.config/wallpaper/wallpaper.conf`:

```bash
WALLPAPER_DIRS=(
    "${DOTFILES_ROOT:-$HOME/git/dotfiles}/pictures"
    "$HOME/Pictures/Wallpapers"
    "/usr/share/hypr/wall*.png"
)
WALLPAPER_FIT="cover"   # cover | contain | tile | fill
WALLPAPER_NOTIFY=1      # 1 = desktop notification on change, 0 = silent
```

Supported formats: `PNG`, `JPG/JPEG`, `WebP`, `GIF`, `BMP`, `AVIF`, `JXL`, `TIF/TIFF`.

---

## Files & State Paths

| Path | Purpose |
| :--- | :--- |
| `~/git/dotfiles/pictures` | Private wallpaper repository (gitignored) |
| `~/git/dotfiles/scripts/install-wallpapers.sh` | Helper script invoked by `adot wallpapers` / `adot update wallpapers` |
| [`wallpaper.conf`](wallpaper.conf) (`~/.config/wallpaper/wallpaper.conf`) | Search directories, fit mode (`cover\|contain\|tile\|fill`), notification toggle |
| [`wallpaper.sh`](wallpaper.sh) (`~/.config/wallpaper/wallpaper.sh`) | Main CLI & TUI executable (symlinked to `~/.local/bin/wallpaper`, alias `wp`) |
| `~/.local/state/wallpaper/state` | Persistent default & per-monitor overrides (kept outside the Git repo) |
| `~/.config/hypr/hyprpaper.conf` | Base `hyprpaper` daemon config (`splash = false`) |

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
