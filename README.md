<div align="center">

# Arch Linux Dotfiles (`arch-dotfiles`)

**A cohesive, modular, high-performance Wayland & terminal development ecosystem.**

Arch Linux · Hyprland · Waybar · Ghostty · Kitty · Foot · Zsh · tmux · Neovim · Vim · Yazi · Catppuccin Mocha

[![Docs](https://readthedocs.org/projects/arch-dotfiles/badge/?version=latest)](https://arch-dotfiles.readthedocs.io/en/latest/)
[![Neovim Docs](https://img.shields.io/badge/docs-nvim--config-89b4fa?logo=neovim&logoColor=white)](https://nvim-config.readthedocs.io/en/latest/)
[![tmux Docs](https://img.shields.io/badge/docs-tmux--config-1BB91F?logo=tmux&logoColor=white)](https://tmux-config.readthedocs.io/en/latest/)
[![Ghostty Docs](https://img.shields.io/badge/docs-ghostty--config-cba6f7?logo=gnometerminal&logoColor=white)](https://ghostty-config.readthedocs.io/en/latest/)
[![Kitty Docs](https://img.shields.io/badge/docs-kitty--config-94e2d5?logo=gnometerminal&logoColor=white)](https://kitty-config.readthedocs.io/en/latest/)
[![Vim Docs](https://img.shields.io/badge/docs-vim--config-a6e3a1?logo=vim&logoColor=white)](https://vim-config.readthedocs.io/en/latest/)
[![Platform: Arch Linux](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Linux%20%7C%20macOS-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[**Ecosystem Documentation**](https://arch-dotfiles.readthedocs.io/en/latest/) ·
[Installation](https://arch-dotfiles.readthedocs.io/en/latest/installation/) ·
[Hyprland & Keybindings](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/) ·
[Shell & CLI Commands](https://arch-dotfiles.readthedocs.io/en/latest/shell/) ·
[Git Subtrees](https://arch-dotfiles.readthedocs.io/en/latest/subtrees/)

</div>

---

## Overview & Philosophy

This repository (`~/git/dotfiles`) is the central configuration hub for a complete, distraction-free developer workstation built around **Arch Linux**, **Hyprland**, and the **Catppuccin Mocha** pastel palette.

- **Ready for Any Arch Linux System — Adaptable Everywhere**: Every component is structured so that anyone can install the entire environment out-of-the-box on **Arch Linux** with a single command (`adot install` or `./scripts/install.sh`). Because configurations are cleanly separated into modular directories and standalone subtrees, the setup (or individual parts of it) can also be run on **other Linux distributions, macOS, or WSL2** with only minor adjustments (such as package manager names or binary paths).
- **Clean XDG Symlink Architecture**: All configuration directories reside in `~/git/dotfiles` and are symlinked into `~/.config/<module>` (plus `~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`, and CLI programs in `~/.local/bin/`). Your `~/.config` directory remains completely free of `.git` clutter and runtime state.
- **Unified CLI Program (`adot` / `arch-dot` / `arch-dotfiles`)**: Instead of remembering individual helper scripts, everything is managed through a single CLI program (`adot`, also accessible as `arch-dot` or `arch-dotfiles` in `~/.local/bin/`). Run `adot install` for initial provisioning, `adot update` to update the entire system (or `adot update nvim` for a single subtree), `adot status` to inspect the live state of all managed modules, and `adot list` / `adot keys` / `adot commands` / `adot scripts` to view all custom keybindings, commands, and scripts directly in the terminal.
- **Self-Contained Git Subtrees**: Core tools (`nvim`, `tmux`, `ghostty`, `kitty`, `foot`, `vim`) are maintained in their own dedicated repositories with dedicated documentation, but are embedded directly via **Git Subtrees** — no `--recurse-submodules` required when cloning, no detached HEAD states.

---

## Documentation Hub

The ecosystem is documented across six interconnected **Read the Docs** sites. The main hub covers the overall system, desktop, shell, and subtree orchestration, while the dedicated tool repositories provide their own deep-dive manuals for Neovim, tmux, Ghostty, Kitty, and Vim:

| Project | Role | GitHub Repository | Documentation (Read the Docs) |
| :--- | :--- | :--- | :--- |
| **`arch-dotfiles`** *(Main Hub)* | Full Arch Linux & Hyprland Ecosystem | [`MichaelWeissDEV/dotfiles`](https://github.com/MichaelWeissDEV/dotfiles) | [**arch-dotfiles.readthedocs.io**](https://arch-dotfiles.readthedocs.io/en/latest/) |
| **`nvim-config`** | Reproducible, Offline-Capable Neovim IDE | [`MichaelWeissDEV/nvim-config`](https://github.com/MichaelWeissDEV/nvim-config) | [**nvim-config.readthedocs.io**](https://nvim-config.readthedocs.io/en/latest/) |
| **`tmux-config`** | Portable, Fast Terminal Multiplexer | [`MichaelWeissDEV/tmux-config`](https://github.com/MichaelWeissDEV/tmux-config) | [**tmux-config.readthedocs.io**](https://tmux-config.readthedocs.io/en/latest/) |
| **`ghostty-config`** | Minimalist GPU Terminal (Ghostty) | [`MichaelWeissDEV/ghostty-config`](https://github.com/MichaelWeissDEV/ghostty-config) | [**ghostty-config.readthedocs.io**](https://ghostty-config.readthedocs.io/en/latest/) |
| **`kitty-config`** | GPU Terminal with Powerline Tabs (Kitty) | [`MichaelWeissDEV/kittiy-config`](https://github.com/MichaelWeissDEV/kittiy-config) | [**kitty-config.readthedocs.io**](https://kitty-config.readthedocs.io/en/latest/) |
| **`vim-config`** | Zero-Plugin Standalone Vim Configuration | [`MichaelWeissDEV/vim-config`](https://github.com/MichaelWeissDEV/vim-config) | [**vim-config.readthedocs.io**](https://vim-config.readthedocs.io/en/latest/) |

The **Foot** configuration is maintained as a standalone repository ([`MichaelWeissDEV/foot-config`](https://github.com/MichaelWeissDEV/foot-config)) and documented in the [Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/).

---

## Repository Structure & Symlink Map

| Directory / Component | Key Configuration Files | Target Symlink(s) | Documentation |
| :--- | :--- | :--- | :--- |
| **[`scripts/`](scripts/)** | [`scripts/adot`](scripts/adot), [`scripts/install.sh`](scripts/install.sh), [`scripts/install-links.sh`](scripts/install-links.sh), [`scripts/update-subtrees.sh`](scripts/update-subtrees.sh) | `~/.local/bin/adot`, `~/.local/bin/arch-dot`, `~/.local/bin/arch-dotfiles` | [README](scripts/README.md) · [Guide](https://arch-dotfiles.readthedocs.io/en/latest/shell/) |
| **[`hypr/`](hypr/)** | [`hypr/hyprland.lua`](hypr/hyprland.lua), [`hypr/hyprpaper.conf`](hypr/hyprpaper.conf), [`hypr/hyprlock.conf`](hypr/hyprlock.conf), [`hypr/askpass.sh`](hypr/askpass.sh) | `~/.config/hypr` | [README](hypr/README.md) · [Docs](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/) |
| **[`waybar/`](waybar/)** | [`waybar/config.jsonc`](waybar/config.jsonc), [`waybar/style.css`](waybar/style.css), [`waybar/power_menu.xml`](waybar/power_menu.xml) | `~/.config/waybar` | [README](waybar/README.md) · [Docs](https://arch-dotfiles.readthedocs.io/en/latest/waybar/) |
| **[`fuzzel/`](fuzzel/)** | [`fuzzel/fuzzel.ini`](fuzzel/fuzzel.ini) | `~/.config/fuzzel` | [README](fuzzel/README.md) · [Guide](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/#application-launcher--power-menu) |
| **[`wallpaper/`](wallpaper/)** | [`wallpaper/wallpaper.sh`](wallpaper/wallpaper.sh), [`wallpaper/wallpaper.conf`](wallpaper/wallpaper.conf) | `~/.config/wallpaper`, `~/.local/bin/wallpaper` | [README](wallpaper/README.md) · [Guide](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/#wallpaper-management-hyprpaper) |
| **[`ghostty/`](ghostty/)** | [`ghostty/config`](ghostty/config) *(Git Subtree: `MichaelWeissDEV/ghostty-config`)* | `~/.config/ghostty` | [README](ghostty/README.md) · [Docs](https://ghostty-config.readthedocs.io/en/latest/) |
| **[`kitty/`](kitty/)** | [`kitty/kitty.conf`](kitty/kitty.conf) *(Git Subtree: `MichaelWeissDEV/kittiy-config`)* | `~/.config/kitty` | [README](kitty/README.md) · [Docs](https://kitty-config.readthedocs.io/en/latest/) |
| **[`foot/`](foot/)** | [`foot/foot.ini`](foot/foot.ini) *(Git Subtree: `MichaelWeissDEV/foot-config`)* | `~/.config/foot` | [README](foot/README.md) · [Docs](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) |
| **[`nvim/`](nvim/)** | [`nvim/init.lua`](nvim/init.lua), [`nvim/lua/`](nvim/lua/) *(Git Subtree: `MichaelWeissDEV/nvim-config`)* | `~/.config/nvim` | [README](nvim/README.md) · [Docs](https://nvim-config.readthedocs.io/en/latest/) |
| **[`tmux/`](tmux/)** | [`tmux/tmux.conf`](tmux/tmux.conf) *(Git Subtree: `MichaelWeissDEV/tmux-config`)* | `~/.config/tmux`, `~/.tmux.conf` | [README](tmux/README.md) · [Docs](https://tmux-config.readthedocs.io/en/latest/) |
| **[`vim/`](vim/)** | [`vim/vimrc`](vim/vimrc) *(Git Subtree: `MichaelWeissDEV/vim-config`)* | `~/.config/vim`, `~/.vimrc` | [README](vim/README.md) · [Docs](https://vim-config.readthedocs.io/en/latest/) |
| **[`zsh/`](zsh/)** | [`zsh/zshrc`](zsh/zshrc), [`zsh/aliases.zsh`](zsh/aliases.zsh), [`zsh/themes/catppuccin.zsh-theme`](zsh/themes/catppuccin.zsh-theme) | `~/.config/zsh`, `~/.zshrc`, `~/.oh-my-zsh/...` | [README](zsh/README.md) · [Docs](https://arch-dotfiles.readthedocs.io/en/latest/shell/) |
| **[`yazi/`](yazi/)** | [`yazi/yazi.toml`](yazi/yazi.toml), [`yazi/theme.toml`](yazi/theme.toml), [`yazi/package.toml`](yazi/package.toml) | `~/.config/yazi` | [README](yazi/README.md) · [Guide](https://arch-dotfiles.readthedocs.io/en/latest/shell/#yazi-directory-tracking-wrapper-y) |
| **`pictures/`** | Private wallpaper library (gitignored for copyright) | Managed via `adot wallpapers` | [Guide](wallpaper/README.md) |
| **[`gtk-3.0/`](gtk-3.0/), [`gtk-4.0/`](gtk-4.0/), [`pcmanfm/`](pcmanfm/), [`libfm/`](libfm/)** | GTK3/GTK4 settings and PCManFM GUI file manager configuration | `~/.config/gtk-3.0`, `~/.config/gtk-4.0`, `~/.config/pcmanfm`, `~/.config/libfm` | [Guide](https://arch-dotfiles.readthedocs.io/en/latest/installation/#symlink-target-map) |

---

## Quick Start & Installation

### 1. Clone the Repository

```bash
mkdir -p ~/git
git clone https://github.com/MichaelWeissDEV/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

### 2. Install or Link

```bash
# Option A: Full Arch Linux setup (pacman packages, subtrees, Oh My Zsh + plugins, symlinks & systemd services)
./scripts/install.sh

# Option B: Create symlinks only (safe on any Linux/macOS system, no sudo or network required)
./scripts/install-links.sh
```

> **Using on other Linux distributions or macOS:** Run `./scripts/install-links.sh` (or install individual subtrees like `nvim`, `tmux`, `ghostty`, `kitty`, `foot`, `vim`) and install the equivalent packages using your native package manager (`apt`, `dnf`, `brew`, etc.).

---

## Managing & Updating Everything (`adot` / `arch-dot` / `arch-dotfiles`)

The installer links the unified CLI program **`adot`** (along with **`arch-dot`** and **`arch-dotfiles`**) into `~/.local/bin/` and defines matching Zsh aliases. You do not need to call individual scripts — `adot` orchestrates installation, full or granular updates, status checks, and live terminal reference tables from anywhere:

```bash
# ── 1. INSTALL & UPDATE ───────────────────────────────────────────────────────
adot install                 # Complete Arch Linux setup (pacman, subtrees, Oh My Zsh, symlinks, services)
adot update                  # Update EVERYTHING (pacman, dotfiles, all 6 subtrees, wallpapers, OMZ, symlinks)
adot update nvim             # Update only a single Git subtree (nvim | tmux | ghostty | kitty | foot | vim)
adot update subtrees         # Update all 6 Git subtrees from upstream
adot update dotfiles         # Pull only the main ~/git/dotfiles repository
adot update system           # Update only Arch Linux pacman packages
adot update zsh              # Update only Oh My Zsh & Zsh plugins
adot update wallpapers       # Update only the private wallpaper repository
adot links                   # Create/refresh all symlinks in ~/.config, ~ & ~/.local/bin (no sudo required)
adot packages                # Install/update all 43 managed Arch Linux packages via pacman

# ── 2. INSPECT STATUS & LIST MANAGED ITEMS ────────────────────────────────────
adot status                  # Live dashboard: repo state, symlinks, subtree commits, OMZ, zoxide & packages
adot status --fetch          # Same as above, plus fetch latest upstream SHA hashes from GitHub
adot list                    # Full overview of modules, subtrees, scripts, commands & documentation URLs
adot list modules            # List all 16 managed ~/.config modules and symlink targets
adot list subtrees           # List all 6 embedded Git subtrees, remote names & upstream URLs
adot list packages           # List all 43 managed Arch Linux packages and installed versions
adot list docs               # List all 6 Read the Docs URLs and GitHub repositories

# ── 3. LIST KEYBINDINGS, CUSTOM COMMANDS & SCRIPTS IN TERMINAL ────────────────
adot keys                    # List all custom keybindings across the entire ecosystem
adot keys hypr               # Filter keybindings by component (hypr | nvim | vim | tmux | terminals | shell)
adot commands                # List all custom CLI commands, shell functions (j/ji, y, fznv, ...) & aliases
adot scripts                 # List all CLI binaries in ~/.local/bin and helper scripts in ~/git/dotfiles

# ── 4. SUBTREE PUSH & WALLPAPERS ──────────────────────────────────────────────
adot push nvim               # Push local subtree commits to upstream GitHub (nvim|tmux|ghostty|kitty|foot|vim|all)
adot wallpapers <git-url>    # Clone private wallpaper repository into ~/git/dotfiles/pictures
adot wallpapers --update     # Pull latest changes in private wallpaper repository
```

*(Note: `arch-dot <cmd>` and `arch-dotfiles <cmd>` are 100% identical to `adot <cmd>`.)*

---

## Custom CLI Commands, Aliases & Keybindings Overview

### 1. Custom Shell Commands & Aliases (`zsh/zshrc` & `zsh/aliases.zsh`)

| Command / Alias | Action |
| :--- | :--- |
| **`adot update`** / **`arch-dot update`** / **`arch-dotfiles update`** | Update everything (`all`) or a specific target (`nvim`, `tmux`, `ghostty`, `kitty`, `foot`, `vim`, `subtrees`, `dotfiles`, `system`, `zsh`, `wallpapers`) |
| **`adot status [--fetch]`** | Show live status dashboard of repo, symlinks, all 6 subtrees, Oh My Zsh, `zoxide` & Arch packages |
| **`adot list [category]`** | List `modules`, `subtrees`, `keys`, `commands`, `scripts`, `packages`, or `docs` |
| **`adot keys [section]`** | Print keybinding tables in terminal (`hypr`, `nvim`, `vim`, `tmux`, `terminals`, `shell`, or `all`) |
| **`adot commands`** / **`adot scripts`** / **`adot docs`** | Print all custom commands & aliases / managed scripts / Read the Docs links |
| **`adot install`** / **`adot links`** / **`adot packages`** | Run full setup / refresh symlinks (`cfg-links`) / install Arch packages |
| **`adot subtrees [mod]`** / **`adot push [mod]`** | Pull subtree(s) from upstream (`cfg-subtrees`) / Push subtree commits to GitHub |
| **`adot wallpapers`** / **`cfg-wallpapers`** | Clone or update the private wallpaper repository (`pictures/`) |
| **`j <dir>`** / **`ji`** *(powered by `zoxide`, aliases `z` / `zi`)* | **Jump (`j`)** to smart frecent directory or open interactive `fzf` directory picker (`ji`) — powered under the hood by **zoxide** |
| **`y [path]`** | Launch `yazi` TUI file manager and automatically `cd` into the last visited directory on exit (`q`) |
| **`dotfiles`** | `cd ~/git/dotfiles` |
| **`wallpaper`** / **`wp`** | Multi-monitor wallpaper CLI & Fuzzel TUI (`wallpaper`, `wallpaper list`, `wallpaper set ...`) |
| **`nv`** / **`v`** | Launch Neovim (`nvim`) / standalone Vim (`vim`) |
| **`fznv`** / **`fzv`** | Fuzzy-find a file interactively with `fzf` and open it in Neovim / Vim |
| **`tm`** / **`tn <name>`** / **`ta <name>`** / **`tl`** | Attach/create `main` tmux session / new named session / attach session / list sessions |
| **`ll`** / **`la`** | Colorized `ls -lah` / `ls -A` |
| **`Esc` `Esc`** *(Oh My Zsh `sudo` plugin)* | Prefix current or previous command with `sudo` |

### 2. Essential Hyprland Keybindings (`hypr/hyprland.lua`)

Full reference: [`hypr/README.md`](hypr/README.md) & [Hyprland Docs](https://arch-dotfiles.readthedocs.io/en/latest/hyprland/).

| Keybinding | Action |
| :--- | :--- |
| `SUPER + Space` *(or `ALT + Space`, `SUPER + D/R/A`)* | Open application launcher (`fuzzel`) |
| `SUPER + Return` *(or `SUPER + Q`)* | Open terminal (`kitty`) |
| `SUPER + SHIFT + Return` | Open terminal directly inside persistent `tmux` session (`main`) |
| `SUPER + E` / `SUPER + Y` / `SUPER + B` | Open GUI file manager (`pcmanfm`) / TUI file manager (`yazi`) / Browser (`firefox`) |
| `ALT + Tab` *(or `SUPER + Tab` / `SUPER + BackSpace`)* | **Instant Ping-Pong Jump** to last active window across all monitors & workspaces |
| `ALT + SHIFT + Tab` *(or `SUPER + SHIFT + Tab`)* | Cycle through all open windows across all monitors & workspaces |
| `SUPER + ^` *(key below `Esc`)* | Cycle through windows of the **same application class** across all monitors |
| `SUPER + G` *(or `SUPER + #`)* | Open interactive **Window & Slot Switcher** (`windowswitcher.sh` via `fuzzel`) |
| `SUPER + CTRL + 1..0` / `SUPER + CTRL + F1..F4` | Pin active window to cross-monitor **Slot `1..10`** / **Quick Slot `1..4`** |
| `SUPER + ALT + 1..0` / `SUPER + F1..F4` | **Instant Jump** to pinned window in Slot `1..10` / `1..4` (press again to jump back!) |
| `SUPER + O` *(or `SUPER + <`)* | Focus next physical monitor |
| `SUPER + SHIFT + O` / `SUPER + CTRL + O` | Move active window to next monitor / Swap active workspaces between monitors |
| `SUPER + 1..0` / `SUPER + SHIFT + 1..0` | Switch to workspace `1..10` / Move active window to workspace `1..10` |
| `CTRL + ALT + 1..0` | Switch to workspace/monitor `1..10` **only if it already exists** (no empty workspaces created) |
| `SUPER + .` / `SUPER + ,` / `SUPER + N` | Next workspace (`r+1`) / Previous workspace (`r-1`) / Next empty workspace |
| `SUPER + S` / `SUPER + SHIFT + S` | Toggle scratchpad (`special:magic`) / Move active window to scratchpad |
| `SUPER + C` *(or `SUPER + W`)* | Close active window |
| `SUPER + F` / `SUPER + SHIFT + F` / `SUPER + V` | Toggle fullscreen / Toggle maximize (keeps Waybar) / Toggle floating |
| `SUPER + SHIFT + W` | Open interactive multi-monitor Wallpaper TUI (`wallpaper`) |
| `SUPER + L` / `SUPER + Escape` | Lock screen (`hyprlock`) / Open Fuzzel Power Menu |
| `Print` / `SUPER + SHIFT + P` | Screenshot full screen / selected region (saved to `~/Downloads` & copied to clipboard) |

### 3. Editor & Multiplexer Keybindings

- **Neovim (`nvim-config`)**: `<Space>` Leader · `<Space>ff` find files · `<Space>fg` live grep · `<Space>e` file tree · `<Space>o` / `-` Oil buffer explorer · `<Space>tl` `:LangInstall` · `gd`/`gr`/`K` LSP navigation · `:NvimKeymaps` & `:NvimCommands`. → [Full Neovim Keymaps & Commands](https://nvim-config.readthedocs.io/en/latest/keymaps/)
- **Vim (`vim-config`)**: `<Space>` Leader · `<Space>un` / `<Space>rn` / `<Space>n` / `<F3>` toggle relative ↔ absolute line numbers · `<Space>uN` toggle numbers off · `Ctrl+h/j/k/l` split navigation · `Shift+H`/`Shift+L` buffer cycle · `<Space>wv`/`ws`/`wc`/`we` window splits. → [Full Vim Keybindings](https://vim-config.readthedocs.io/en/latest/keybindings/)
- **tmux (`tmux-config`)**: `Ctrl+b` Prefix · `Prefix + H` interactive **Key Explorer popup** · `Prefix + |` / `_` split side-by-side / stacked · `Prefix + h/j/k/l` pane navigation · `Prefix + R` reload config. → [Full tmux Keybindings](https://tmux-config.readthedocs.io/en/latest/keybindings/quick/)
- **Kitty & Ghostty**: `Ctrl+Shift+C` / `Ctrl+Shift+V` clipboard · `Ctrl+Shift+F5` (Kitty) / `Ctrl+Shift+,` (Ghostty) live config reload. → [Kitty Keybindings](https://kitty-config.readthedocs.io/en/latest/keybindings/) · [Ghostty Keybindings](https://ghostty-config.readthedocs.io/en/latest/keybindings/)

---

## Git Repositories & Subtree Management

### 1. Embedded Git Subtrees

Because `nvim`, `tmux`, `ghostty`, `kitty`, `foot`, and `vim` are embedded as **Git Subtrees**, all files are present immediately after a standard `git clone`.

| Subtree Path | Remote Name | Upstream GitHub Repository | Branch | Documentation |
| :--- | :--- | :--- | :--- | :--- |
| **`nvim/`** | `nvim-remote` | `https://github.com/MichaelWeissDEV/nvim-config.git` | `main` | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **`tmux/`** | `tmux-remote` | `https://github.com/MichaelWeissDEV/tmux-config.git` | `main` | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **`ghostty/`** | `ghostty-remote` | `https://github.com/MichaelWeissDEV/ghostty-config.git` | `main` | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **`kitty/`** | `kitty-remote` | `https://github.com/MichaelWeissDEV/kittiy-config.git` | `main` | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **`foot/`** | `foot-remote` | `https://github.com/MichaelWeissDEV/foot-config.git` | `main` | [Terminals Guide](https://arch-dotfiles.readthedocs.io/en/latest/terminals/) |
| **`vim/`** | `vim-remote` | `https://github.com/MichaelWeissDEV/vim-config.git` | `main` | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |

```bash
# Check status of all 6 subtrees & remotes:
arch-dot status

# Pull all 6 subtrees from upstream (or use: cfg-subtrees):
arch-dot subtrees

# Pull a single subtree from upstream:
arch-dot subtrees nvim       # (nvim | tmux | ghostty | kitty | foot | vim)

# Push local commits from a subtree directory back to its upstream repository:
arch-dot push nvim           # (nvim | tmux | ghostty | kitty | foot | vim | all)
```

<details>
<summary><b>Manual <code>git subtree</code> commands (without helper script)</b></summary>

```bash
cd ~/git/dotfiles

# 1. Ensure all 6 remotes are registered (one-time setup after fresh clone):
git remote add nvim-remote    https://github.com/MichaelWeissDEV/nvim-config.git
git remote add tmux-remote    https://github.com/MichaelWeissDEV/tmux-config.git
git remote add ghostty-remote https://github.com/MichaelWeissDEV/ghostty-config.git
git remote add kitty-remote   https://github.com/MichaelWeissDEV/kittiy-config.git
git remote add foot-remote    https://github.com/MichaelWeissDEV/foot-config.git
git remote add vim-remote     https://github.com/MichaelWeissDEV/vim-config.git

# 2. Fetch and merge upstream changes with --squash:
git fetch nvim-remote main    && git subtree pull --prefix=nvim    nvim-remote    main --squash -m "Update nvim subtree from upstream"
git fetch tmux-remote main    && git subtree pull --prefix=tmux    tmux-remote    main --squash -m "Update tmux subtree from upstream"
git fetch ghostty-remote main && git subtree pull --prefix=ghostty ghostty-remote main --squash -m "Update ghostty subtree from upstream"
git fetch kitty-remote main   && git subtree pull --prefix=kitty   kitty-remote   main --squash -m "Update kitty subtree from upstream"
git fetch foot-remote main    && git subtree pull --prefix=foot    foot-remote    main --squash -m "Update foot subtree from upstream"
git fetch vim-remote main     && git subtree pull --prefix=vim     vim-remote     main --squash -m "Update vim subtree from upstream"

# 3. Push local commits back to the respective upstream repo:
git subtree push --prefix=nvim    nvim-remote    main
git subtree push --prefix=tmux    tmux-remote    main
git subtree push --prefix=ghostty ghostty-remote main
git subtree push --prefix=kitty   kitty-remote   main
git subtree push --prefix=foot    foot-remote    main
git subtree push --prefix=vim     vim-remote     main
```

</details>

### 2. External Zsh Repositories (Cloned Locally by `install.sh`)

| Component | Target Path | Repository URL |
| :--- | :--- | :--- |
| **Oh My Zsh** | `~/.oh-my-zsh` | `https://github.com/ohmyzsh/ohmyzsh.git` |
| **zsh-autosuggestions** | `~/.oh-my-zsh/custom/plugins/zsh-autosuggestions` | `https://github.com/zsh-users/zsh-autosuggestions.git` |
| **zsh-syntax-highlighting** | `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting` | `https://github.com/zsh-users/zsh-syntax-highlighting.git` |

---

## Multi-Monitor Wallpaper Switcher (`wallpaper/`)

The custom wallpaper switcher manages backgrounds via **hyprpaper** — supporting a **global default for all screens** as well as **per-monitor overrides**. Full documentation: [`wallpaper/README.md`](wallpaper/README.md).

```bash
wallpaper                              # Open Fuzzel TUI (choose target monitor + wallpaper)
wallpaper list                         # List available wallpapers (★ = Default, ● = Monitor Override)
wallpaper set forest.png               # Set default wallpaper for all monitors without override
wallpaper set ocean.png --monitor DP-1 # Set dedicated wallpaper for monitor DP-1
wallpaper set city.png --all           # Set everywhere and clear all monitor overrides
wallpaper monitor DP-1 default         # Remove override for DP-1 (reverts to default)
wallpaper current                      # Show active assignments per monitor
wallpaper add ~/Downloads/pic.jpg --set # Copy image into library and apply as default
```

### Private Wallpaper Repository (`pictures/`)

Wallpaper image files are stored in `~/git/dotfiles/pictures/`, which is excluded via `.gitignore` (for copyright reasons) and cloned as a standalone private Git repository rather than a submodule:

```bash
# Clone private wallpaper repository (one-time):
arch-dot wallpapers <git-url>

# Update existing wallpaper repository:
arch-dot wallpapers --update
```

> **Note:** Because `pictures/` is gitignored, running `git clean -fdx` in the root dotfiles repository would delete `pictures/`. Always commit and push changes inside `~/git/dotfiles/pictures` before running a force-clean.

---

## Included Arch Linux Packages (`pacman`)

Running `./scripts/install.sh` (or `arch-dot packages`) installs the following packages from the official Arch Linux repositories (`pacman -Syu --needed`):

- **Hyprland & Wayland Desktop**: `hyprland`, `hyprpaper`, `hyprlock`, `hypridle`, `waybar`, `fuzzel`, `xdg-desktop-portal-hyprland`, `wl-clipboard`, `grim`, `slurp`, `brightnessctl`, `power-profiles-daemon`
- **Audio (PipeWire), Network & Bluetooth**: `pipewire`, `pipewire-alsa`, `pipewire-pulse`, `pipewire-jack`, `wireplumber`, `gst-plugin-pipewire`, `libpulse`, `networkmanager`, `bluez`, `bluez-utils`
- **Terminals & Shell**: `ghostty`, `kitty`, `foot`, `zsh`, `tmux`
- **Editors & CLI Utilities**: `neovim`, `vim`, `git`, `fzf`, `zoxide`, `ripgrep`, `fd`, `jq`, `wget`, `man-db`, `man-pages`
- **File Managers, Browser & Fonts**: `yazi`, `pcmanfm`, `firefox`, `ttf-jetbrains-mono-nerd`, `noto-fonts`

---

## Author & License

**Michael Weiss** — [GitHub (`@MichaelWeissDEV`)](https://github.com/MichaelWeissDEV)

Released under the [MIT License](nvim/LICENSE).
