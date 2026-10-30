# Shell, CLI Commands & Productivity Aliases

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
[Paket-Migration](subtrees.md)

The command-line environment centers on **Zsh** (`~/.config/zsh/zshrc` and `~/.config/zsh/aliases.zsh`) enhanced with **Oh My Zsh**, Catppuccin Mocha syntax highlighting, asynchronous autosuggestions, FZF integration, and custom CLI tools (`adot` / `arch-dot` / `arch-dotfiles` and `wallpaper`).

---

## Prompt & Environment (`zsh/zshrc`)

- **Default Editor**: `EDITOR="nvim"` and `VISUAL="nvim"`
- **Graphical Sudo Prompt**: `SUDO_ASKPASS="$HOME/.config/hypr/askpass.sh"` (uses `fuzzel --dmenu --password` in Wayland sessions)
- **PATH**: Automatically prepends `~/.local/bin` so custom CLI tools (`arch-dot`, `arch-dotfiles`, `wallpaper`) are available everywhere.
- **Minimal Prompt**: Clean `> ` prompt indicator with zero visual clutter, paired with the custom theme at `~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme`.
- **TUI Styling (`NEWT_COLORS`)**: Pre-configured Catppuccin Mocha color variables for `nmtui` and other libnewt TUI utilities.

---

## Active Oh My Zsh Plugins & Keybindings

| Plugin / Integration | Keybinding / Trigger | Description |
| :--- | :--- | :--- |
| **`sudo`** | <kbd>Esc</kbd> <kbd>Esc</kbd> *(press Escape twice)* | Automatically prefixes the current or previous command line with `sudo` |
| **`zsh-autosuggestions`** | <kbd>→</kbd> *(Right Arrow)* or <kbd>End</kbd> | Accepts the inline historical command suggestion (rendered in muted Overlay0 `#6c7086`) |
| **`zsh-syntax-highlighting`** | Live while typing | Highlights valid commands in Pastel Blue (`#89b4fa`), aliases in Teal (`#94e2d5`), builtins in Mauve (`#cba6f7`), strings in Green (`#a6e3a1`), and invalid tokens in Red (`#f38ba8`) |
| **`fzf --zsh`** | <kbd>Ctrl</kbd> + <kbd>R</kbd> / <kbd>Ctrl</kbd> + <kbd>T</kbd> / <kbd>Alt</kbd> + <kbd>C</kbd> | Fuzzy search command history (`Ctrl+R`), insert file path (`Ctrl+T`), or fuzzy `cd` into directory (`Alt+C`) |
| **`zoxide init zsh --cmd j`** | **`j <query>`** / **`ji`** *(also `z` / `zi`)* | **Smart Directory Jump (`j` for jump)** powered under the hood by **zoxide**: jumps to the highest-ranked matching directory (`j`) or opens an interactive `fzf` directory picker (`ji`) |
| **`git`** | `gst`, `ga`, `gc`, `gp`, `gl`, ... | Standard Oh My Zsh Git aliases and completions |

---

## Custom CLI Programs (`/usr/bin`)

### 1. `adot` / `arch-dot` / `arch-dotfiles` (Unified Ecosystem & Dotfiles Manager)

Provided by `arch-dotfiles-core` as `/usr/bin/adot`, `arch-dot`, and
`arch-dotfiles`. Updates use Pacman exclusively; there are no runtime subtree
pulls or Git clones. See [package setup and activation](arch-package.md).

| Command | Action |
| :--- | :--- |
| `adot update` | Run `sudo pacman -Syu`, then safely synchronize user copies |
| `adot sync` | Synchronize defaults only, e.g. after running Pacman yourself |
| `adot status` | Inspect activation and user configuration paths |
| `adot list` | List installed dotfiles packages |
| `adot keys` / `adot docs` | Show documentation locations |
| `adot commands` | Show package-management commands |
| `adot scripts` | Show available helper binaries |
| `adot install [module ...]` / `adot links [module ...]` | Activate installed modules without sudo |
| `adot deactivate [module ...]` | Restore previous settings |
| `adot packages [package ...]` | Install selected packages with `pacman -Syu --needed` (default: metapackage) |
| `adot path` | Print the editable user configuration directory |
| `adot help` | Display help message and subcommands |

### 2. `wallpaper` (Multi-Monitor Wallpaper Manager)

Provided by `arch-dotfiles-wallpaper`; prefers the activated user script
`~/.config/wallpaper/wallpaper.sh` (alias: `wp`):

| Command | Action |
| :--- | :--- |
| `wallpaper` *(or `wp`)* | Launch interactive Fuzzel TUI (choose target monitor + wallpaper) |
| `wallpaper list [--monitor MON] [--plain]` | List all wallpapers (`★` = global default, `●` = monitor override) |
| `wallpaper set <name\|path> [--monitor MON \| --all]` | Set global default, per-monitor override, or apply everywhere (`--all`) |
| `wallpaper default [<name\|path>]` | Show or set the global default wallpaper |
| `wallpaper monitor <MON> [<name\|path>\|default]` | Show, set, or remove a per-monitor override |
| `wallpaper clear <MON> \| --all` | Clear override for `<MON>` or all monitors |
| `wallpaper current` | Show saved state and active wallpapers per connected monitor |
| `wallpaper next` / `wallpaper prev` / `wallpaper random` | Cycle to next, previous, or random wallpaper |
| `wallpaper add <file>... [--move] [--set]` | Copy/move images into the user library and optionally apply |
| `wallpaper apply` / `wallpaper reload` | Apply saved state / restart `hyprpaper` and re-apply |
| `wallpaper dirs` / `wallpaper open` / `wallpaper doctor` | Show configured directories / open in file manager / run diagnostics |

---

## Custom Aliases & Shell Functions (`zsh/aliases.zsh`)

### Dotfiles & Maintenance Aliases

| Alias | Command Executed | Purpose |
| :--- | :--- | :--- |
| `dotfiles` | `cd "${XDG_DATA_HOME:-$HOME/.local/share}/arch-dotfiles/config"` | Jump to editable configuration copies |
| `cfg-update` | `adot update` | Full system upgrade and user sync |
| `cfg-links` | `arch-dotfiles-config activate` | Activate installed modules |
| `wp` | `wallpaper` | Short alias for the wallpaper manager |

### Text Editors & Interactive Fuzzy Openers

| Alias / Function | Implementation | Purpose |
| :--- | :--- | :--- |
| `nv` | `nvim` | Open [Neovim (`nvim-config`)](https://nvim-config.readthedocs.io/en/latest/) |
| `v` | `vim` | Open standalone [Vim (`vim-config`)](https://vim-config.readthedocs.io/en/latest/) |
| `fznv [args]` | `fzf --height=40% --layout=reverse --border --prompt='nvim > '` -> `nvim` | Fuzzy-find a file interactively and open it in Neovim |
| `fzv [args]` | `fzf --height=40% --layout=reverse --border --prompt='vim > '` -> `vim` | Fuzzy-find a file interactively and open it in Vim |

### Smart Directory Jumping with `j` (Powered by `zoxide`)

Directory navigation uses the short command **`j`** (for **jump**), backed under the hood by **`zoxide`** (`eval "$(zoxide init zsh --cmd j)"`):

| Command | Action |
| :--- | :--- |
| **`j <pattern>`** *(or `z <pattern>`)* | **Jump (`j`)** directly to the highest-ranked directory matching `<pattern>` based on frecency (`zoxide` database) |
| **`ji`** *(or `zi`)* | Open an **interactive `fzf` directory picker** over your `zoxide` history and jump to the selection |
| **`j -`** *(or `z -`)* | Jump back to the previous directory |

### Yazi Directory-Tracking Wrapper (`y`)

The `y` shell function wraps `yazi` (`yazi "$@" --cwd-file="$tmp"`). When you navigate through directories in Yazi and press <kbd>q</kbd> to quit, your current Zsh shell automatically `cd`s into the last directory you visited:

```bash
y [path]
```

### tmux Session Shortcuts

See the full [tmux-config Documentation](https://tmux-config.readthedocs.io/en/latest/) for internal tmux bindings.

| Alias | Command Executed | Purpose |
| :--- | :--- | :--- |
| `tm` | `tmux new-session -A -s main` | Attach to primary session `main` (or create it if not running) |
| `tn <name>` | `tmux new-session -s <name>` | Create a new named tmux session |
| `ta <name>` | `tmux attach -t <name>` | Attach to an existing named tmux session |
| `tl` | `tmux list-sessions` | List all active tmux sessions |

### Colorized System Utilities

| Alias | Command Executed |
| :--- | :--- |
| `ls` | `ls --color=auto` |
| `ll` | `ls -lah --color=auto` |
| `la` | `ls -A --color=auto` |
| `grep` | `grep --color=auto` |
| `diff` | `diff --color=auto` |
| `ip` | `ip -color=auto` |

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
