# Shell & Productivity Aliases

The command-line environment centers on **Zsh** enhanced with **Oh My Zsh**, asynchronous suggestions, syntax highlighting, and an intentional collection of fast aliases.

---

## Prompt Theme: Catppuccin Mocha

The custom prompt theme lives at `~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme`. It provides a clean, two-line layout:

```text
┌──  ~/git/dotfiles on  main [✔]
└──>
```

- **Directory**: Rendered in soft Teal (`#94e2d5`).
- **Git Branch**: Highlighted in Lavender (`#b4befe`) with dirty indicator (`*` in Peach).
- **Return Code**: Displays Green checkmark (`✔`) on success or Red cross (`✘`) with error code on failure.
- **Prompt Symbol**: Minimal `>` arrow in Pastel Blue (`#89b4fa`).

---

## Active Plugins

1. **`git`**: Provides comprehensive git command shorthands and status parsing.
2. **`sudo`**: Pressing <kbd>Esc</kbd> twice automatically prepends `sudo` to the current (or previous) command.
3. **`zsh-autosuggestions`**: Suggests historical commands asynchronously in muted gray; press <kbd>→</kbd> (Right Arrow) to accept.
4. **`zsh-syntax-highlighting`**: Highlights commands in green (valid), red (unknown), or cyan (aliases) while typing.

---

## Productivity Aliases & Helpers

Defined in `~/.config/zsh/aliases.zsh`:

### Text Editors

| Alias / Function | Command Executed | Purpose |
| :--- | :--- | :--- |
| `nv` | `nvim` | Open Neovim |
| `v` | `vim` | Open standalone Vim |
| `fznv` | Interactive `fd \| fzf` -> `nvim` | Interactively search all files and open selection in Neovim |
| `fzv` | Interactive `fd \| fzf` -> `vim` | Interactively search all files and open selection in Vim |

### File Navigation with Yazi (`y`)

The `y` command runs `yazi` with a shell wrapper that tracks directory changes. When you exit Yazi with `q`, your shell automatically `cd`s into the directory you were browsing:

```bash
y [path]
```

### Tmux Session Management

| Command | Action |
| :--- | :--- |
| `tm` | Attach to primary session `main` (creates it automatically if not running) |
| `tn <name>` | Create a new named tmux session |
| `ta <name>` | Attach to an existing named tmux session |
| `tl` | List all running tmux sessions (`tmux list-sessions`) |

### Dotfiles & System Management

| Command | Equivalent Script Call | Purpose |
| :--- | :--- | :--- |
| `dotfiles` | `cd ~/git/dotfiles` | Jump directly into the dotfiles workspace |
| `cfg-update` | `~/git/dotfiles/scripts/install.sh update` | Full update: system packages, subtrees, dotfiles, Zsh plugins |
| `cfg-links` | `~/git/dotfiles/scripts/install-links.sh` | Refresh and verify all `~/.config` symlinks |
| `cfg-subtrees` | `~/git/dotfiles/scripts/update-subtrees.sh` | Pull all 5 subtrees from upstream GitHub repositories |
