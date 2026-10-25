# Installation & Setup Guide

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

This guide describes how to install, link, and maintain the full dotfiles ecosystem on **Arch Linux**, as well as how to adapt it to **other Linux distributions or macOS**.

---

## Prerequisites

- **Primary Target**: Arch Linux (clean installation with `pacman` and `sudo` access).
- **Other Systems (Debian/Ubuntu, Fedora, macOS, WSL2)**: You can deploy all symlinks and use the terminal/editor configurations (`nvim`, `tmux`, `ghostty`, `kitty`, `foot`, `vim`, `zsh`, `yazi`) by running `./scripts/install-links.sh` and installing the required packages with your system's native package manager.
- **Graphic Environment (Desktop)**: Intel, AMD, or NVIDIA GPU with Wayland/KMS drivers.
- **Session**: Standard TTY login (Hyprland is launched on demand via `start-hyprland`).

---

## Installation Steps

### Step 1: Clone the Repository

Clone the repository into `~/git/dotfiles`:

```bash
mkdir -p ~/git
git clone https://github.com/MichaelWeissDEV/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

### Step 2: Run the Installer

The primary installer script `scripts/install.sh` (which also installs the `arch-dot` and `arch-dotfiles` CLI commands into `~/.local/bin`) handles package installation, subtree remote setup, Oh My Zsh plugins, symlink generation, and systemd service activation:

```bash
./scripts/install.sh install
```

During execution, the script:
1. Updates package databases and installs all required Arch Linux official packages via `pacman -Syu --needed`.
2. Verifies and configures all 6 Git subtree remotes (`nvim-remote`, `tmux-remote`, `ghostty-remote`, `kitty-remote`, `foot-remote`, `vim-remote`).
3. Clones Oh My Zsh (`~/.oh-my-zsh`) and installs `zsh-autosuggestions` and `zsh-syntax-highlighting`.
4. Creates atomic symlinks from `~/git/dotfiles/` into `~/.config/`, `$HOME` (`~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`), and `~/.local/bin/` (`arch-dot`, `arch-dotfiles`, `wallpaper`).
5. Enables and starts background services (`NetworkManager.service`, `bluetooth.service`, `power-profiles-daemon.service`) and sets `/usr/bin/zsh` as the default login shell.

### Step 3: Symlink-Only Setup (Portable / Non-Arch Systems)

If you only want to deploy or refresh configuration symlinks without running `pacman` or `sudo`:

```bash
./scripts/install-links.sh
# (or: arch-dot links)
```

---

## Symlink Target Map

All configuration files live inside `~/git/dotfiles` and are linked into `~/.config`, `$HOME`, and `~/.local/bin`:

| Source Directory / File | Target Path | Purpose |
| :--- | :--- | :--- |
| `scripts/adot` | `~/.local/bin/adot`, `~/.local/bin/arch-dot`, `~/.local/bin/arch-dotfiles` | Unified Dotfiles & Ecosystem CLI program ([Guide](shell.md#managing-everything-with-adot--arch-dot)) |
| `hypr/` | `~/.config/hypr` | Hyprland compositor (`hyprland.lua`), `hyprpaper`, `hyprlock`, helper scripts ([Docs](hyprland.md)) |
| `waybar/` | `~/.config/waybar` | Top status bar & GTK power menu config ([Docs](waybar.md)) |
| `fuzzel/` | `~/.config/fuzzel` | Application launcher, sudo askpass & dmenu picker ([Guide](hyprland.md#application-launcher--power-menu)) |
| `wallpaper/` | `~/.config/wallpaper` | Multi-monitor wallpaper switcher config & script ([Guide](hyprland.md#wallpaper-management-hyprpaper)) |
| `wallpaper/wallpaper.sh` | `~/.local/bin/wallpaper` | Wallpaper CLI & Fuzzel TUI executable |
| `ghostty/` | `~/.config/ghostty` | Ghostty terminal configuration ([Docs](https://ghostty-config.readthedocs.io/en/latest/)) |
| `kitty/` | `~/.config/kitty` | Kitty terminal configuration ([Docs](https://kitty-config.readthedocs.io/en/latest/)) |
| `foot/` | `~/.config/foot` | Foot Wayland terminal configuration ([Docs](terminals.md#3-foot-configfootfootini), [Repo](https://github.com/MichaelWeissDEV/foot-config)) |
| `nvim/` | `~/.config/nvim` | Neovim IDE configuration ([Docs](https://nvim-config.readthedocs.io/en/latest/)) |
| `vim/` | `~/.config/vim` | Vim configuration directory ([Docs](https://vim-config.readthedocs.io/en/latest/)) |
| `vim/vimrc` | `~/.vimrc` | Primary Vim configuration file |
| `tmux/` | `~/.config/tmux` | tmux configuration directory ([Docs](https://tmux-config.readthedocs.io/en/latest/)) |
| `tmux/tmux.conf` | `~/.tmux.conf` | Primary tmux configuration loader |
| `zsh/` | `~/.config/zsh` | Zsh configuration & `aliases.zsh` ([Docs](shell.md)) |
| `zsh/zshrc` | `~/.zshrc` | Primary Zsh startup file |
| `zsh/themes/catppuccin.zsh-theme` | `~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme` | Oh My Zsh Catppuccin Mocha theme |
| `yazi/` | `~/.config/yazi` | Yazi TUI file manager & `catppuccin-mocha.yazi` flavor |
| `gtk-3.0/` & `gtk-4.0/` | `~/.config/gtk-3.0`, `~/.config/gtk-4.0` | GTK3 & GTK4 Catppuccin Mocha styling |
| `pcmanfm/` & `libfm/` | `~/.config/pcmanfm`, `~/.config/libfm` | PCManFM GUI file manager preferences |

> **Private wallpaper library:** `pictures/` is not linked into `~/.config`; it is a separate private Git repository inside `~/git/dotfiles/pictures`, excluded from the public repository via `.gitignore` (copyright). Set it up with `arch-dot wallpapers <git-url>`.

---

## Arch Linux Package Inventory (`pacman`)

Running `./scripts/install.sh` or `arch-dot packages` ensures the following official Arch Linux packages are installed:

- **Wayland Desktop & Compositor**: `hyprland`, `hyprpaper`, `hyprlock`, `hypridle`, `waybar`, `fuzzel`, `xdg-desktop-portal-hyprland`, `wl-clipboard`, `grim`, `slurp`, `brightnessctl`, `power-profiles-daemon`
- **Audio (PipeWire), Network & Bluetooth**: `pipewire`, `pipewire-alsa`, `pipewire-pulse`, `pipewire-jack`, `wireplumber`, `gst-plugin-pipewire`, `libpulse`, `networkmanager`, `bluez`, `bluez-utils`
- **Terminals & Shell**: `ghostty`, `kitty`, `foot`, `zsh`, `tmux`
- **Text Editors & CLI Tools**: `neovim`, `vim`, `git`, `fzf`, `zoxide`, `ripgrep`, `fd`, `jq`, `wget`, `man-db`, `man-pages`
- **File Management, Browser & Fonts**: `yazi`, `pcmanfm`, `firefox`, `ttf-jetbrains-mono-nerd`, `noto-fonts`

---

## Managing & Updating Everything (`adot` / `arch-dot` / `arch-dotfiles`)

Once installed, the unified **`adot`** CLI program (also linked as **`arch-dot`** and **`arch-dotfiles`**) is available globally in `~/.local/bin` as well as via Zsh aliases. It calls the internal helper scripts automatically so you can manage the entire ecosystem from a single command:

| Command | Alias Equivalent | Description |
| :--- | :--- | :--- |
| **`adot update`** *(or `arch-dot update`)* | `cfg-update` | **Update everything**: Arch Linux `pacman` packages, `~/git/dotfiles` repo, all 6 Git subtrees (`nvim`, `tmux`, `ghostty`, `kitty`, `foot`, `vim`), private wallpapers (if cloned), Oh My Zsh + plugins, and refresh all symlinks |
| **`adot update <target>`** | – | **Granular update**: update only a single subtree (`nvim`, `tmux`, `ghostty`, `kitty`, `foot`, `vim`), `subtrees` (all 6), `dotfiles`, `system` (pacman), `zsh` (Oh My Zsh), or `wallpapers` |
| **`adot status [--fetch]`** | – | Show live dashboard of repository state, all symlinks, all 6 subtrees (with optional remote SHA fetch), Oh My Zsh, `zoxide`, and installed `pacman` packages |
| **`adot list [category]`** | – | List managed `modules`, `subtrees`, `keys`, `commands`, `scripts`, `packages`, or `docs` |
| **`adot keys [section]`** | – | Print keybinding reference tables (`hypr`, `nvim`, `vim`, `tmux`, `terminals`, `shell`, or `all`) |
| **`adot commands`** | – | List all custom CLI commands, shell functions (`j`/`ji`, `y`, `fznv`, ...), and aliases |
| **`adot scripts`** | – | List all CLI binaries in `~/.local/bin` and helper scripts in `~/git/dotfiles` |
| **`adot docs`** | – | Display all 6 Read the Docs documentation URLs and GitHub repositories |
| **`adot install`** | – | Run complete initial system provisioning |
| **`adot links`** | `cfg-links` | Create/refresh all symlinks in `~/.config`, `~`, and `~/.local/bin` |
| **`adot subtrees [mod]`** | `cfg-subtrees` | Pull all 6 Git subtrees (or a single module: `nvim\|tmux\|ghostty\|kitty\|foot\|vim`) from upstream |
| **`adot push [mod]`** | – | Push local commits from a subtree back to its upstream GitHub repository (`nvim\|tmux\|ghostty\|kitty\|foot\|vim\|all`) |
| **`adot packages`** | – | Install or update required Arch Linux packages via `pacman` |
| **`adot wallpapers [URL\|--update]`** | `cfg-wallpapers` | Clone or update the private wallpaper repository in `~/git/dotfiles/pictures` |
| **`adot help`** | – | Display CLI usage overview |

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
