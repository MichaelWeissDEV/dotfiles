# Installation & Setup Guide

This guide describes how to install and provision the full dotfiles environment on **Arch Linux**.

---

## Prerequisites

- **Distribution**: Arch Linux (clean installation)
- **Privileges**: Standard user with `sudo` permissions
- **Graphic Environment**: Intel, AMD, or NVIDIA GPU with modern KMS/Wayland drivers
- **Session**: TTY login (Hyprland is launched on-demand via `start-hyprland`)

---

## Installation Steps

### Step 1: Clone the Repository

Clone the dotfiles into `~/git/dotfiles`:

```bash
mkdir -p ~/git
git clone https://github.com/MichaelWeissDEV/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

### Step 2: Run the Installer

The primary installer script `scripts/install.sh` handles all package installation, repository configuration, Oh My Zsh plugins, symlink generation, and systemd service activation:

```bash
./scripts/install.sh install
```

During execution, the script:
1. Updates package databases and installs all required Arch Linux official packages via `pacman`.
2. Clones Oh My Zsh and installs `zsh-autosuggestions` and `zsh-syntax-highlighting`.
3. Verifies and configures all 5 Git subtree remotes (`nvim-remote`, `tmux-remote`, `ghostty-remote`, `kitty-remote`, `vim-remote`).
4. Creates atomic symlinks from `~/git/dotfiles/` to `~/.config/` and home directory dotfiles (`~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`).
5. Enables and starts background daemons (`NetworkManager`, `bluetooth`, `power-profiles-daemon`).

### Step 3: Symlink Verification (Standalone)

If you only wish to deploy or re-link configuration files without modifying system packages:

```bash
./scripts/install-links.sh
```

---

## Symlink Target Map

All user-editable configuration files live within `~/git/dotfiles`. The installer links them directly into `~/.config` and `$HOME` so programs run against live repository files:

| Source Directory / File | Target Path | Purpose |
| :--- | :--- | :--- |
| `hypr/` | `~/.config/hypr` | Hyprland compositor, hyprpaper, hyprlock |
| `waybar/` | `~/.config/waybar` | Top status bar & power menu config |
| `fuzzel/` | `~/.config/fuzzel` | Application launcher & dmenu replacement |
| `wallpaper/` | `~/.config/wallpaper` | Wallpaper-switcher daemon & config |
| `wallpaper/wallpaper.sh` | `~/.local/bin/wallpaper` | Wallpaper CLI switcher executable |
| `ghostty/` | `~/.config/ghostty` | Ghostty terminal configuration |
| `kitty/` | `~/.config/kitty` | Kitty terminal configuration |
| `foot/` | `~/.config/foot` | Foot Wayland terminal configuration |
| `nvim/` | `~/.config/nvim` | Neovim Lua IDE configuration |
| `vim/` | `~/.config/vim` | Vim configuration directory |
| `vim/vimrc` | `~/.vimrc` | Vim primary rc file |
| `tmux/` | `~/.config/tmux` | Tmux configuration directory |
| `tmux/tmux.conf` | `~/.tmux.conf` | Tmux primary configuration |
| `zsh/` | `~/.config/zsh` | Zsh aliases and extra shell configurations |
| `zsh/zshrc` | `~/.zshrc` | Primary Zsh runcom file |
| `zsh/catppuccin.zsh-theme` | `~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme` | Oh My Zsh Catppuccin prompt theme |
| `yazi/` | `~/.config/yazi` | Terminal file manager & flavor |
| `gtk-3.0/` | `~/.config/gtk-3.0` | GTK3 theme styling & settings |
| `gtk-4.0/` | `~/.config/gtk-4.0` | GTK4 theme styling & settings |
| `pcmanfm/` | `~/.config/pcmanfm` | GUI file manager configuration |
| `libfm/` | `~/.config/libfm` | File manager preferences |

> **Private wallpaper library:** `pictures/` is not linked into `~/.config`; it is a separate private Git repository inside `~/git/dotfiles/pictures`, excluded from the public dotfiles repository via `.gitignore` (copyright). Set it up with `./scripts/install-wallpapers.sh <git-url>`.

---

## Arch Linux Package Inventory

The installer ensures the following official packages are installed:

### Wayland Desktop & Compositor
`hyprland`, `hyprpaper`, `hyprlock`, `hypridle`, `waybar`, `fuzzel`, `xdg-desktop-portal-hyprland`, `wl-clipboard`, `grim`, `slurp`, `brightnessctl`, `power-profiles-daemon`.

### Audio & Connectivity
`pipewire`, `pipewire-alsa`, `pipewire-pulse`, `pipewire-jack`, `wireplumber`, `gst-plugin-pipewire`, `libpulse`, `networkmanager`, `bluez`, `bluez-utils`.

### Terminals & Shell
`ghostty`, `kitty`, `foot`, `zsh`, `tmux`.

### Text Editors & CLI Tools
`neovim`, `vim`, `git`, `fzf`, `ripgrep`, `fd`, `jq`, `wget`, `man-db`, `man-pages`.

### File Management & Typography
`yazi`, `pcmanfm`, `firefox`, `ttf-jetbrains-mono-nerd`, `noto-fonts`.

---

## Maintenance & Updating Commands

Once installed, management commands are exposed as shell aliases and script subcommands:

```bash
# Update everything (System packages + Dotfiles + Subtrees + Oh My Zsh plugins):
cfg-update
# (or ~/git/dotfiles/scripts/install.sh update)

# Re-link symlinks if new configs were added:
cfg-links
# (or ~/git/dotfiles/scripts/install-links.sh)

# Sync all 5 Git subtrees from upstream GitHub remotes:
cfg-subtrees
# (or ~/git/dotfiles/scripts/update-subtrees.sh)
```
