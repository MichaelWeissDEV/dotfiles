# Git Subtree Architecture

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

The five standalone tool configurations in this ecosystem (**Neovim**, **tmux**, **Ghostty**, **Kitty**, and **Vim**) are maintained as independent GitHub repositories with their own **Read the Docs** sites, while being embedded directly into `~/git/dotfiles` using **Git Subtrees**.

---

## Why Git Subtrees over Submodules?

Traditional Git submodules frequently create friction:
- Fresh clones require `--recurse-submodules` or manual `git submodule update --init --recursive`.
- Repositories easily end up in a `detached HEAD` state when pulling changes.
- Automated installers can fail if external submodule pointers drift.

**With Git Subtrees**:
- All files for all 5 tools live directly inside `~/git/dotfiles`. A standard `git clone` gives you 100% of the working configuration immediately.
- Each tool can still be cloned standalone on any Linux, macOS, or Windows machine by users who only want that single component.
- Changes made inside `nvim/`, `tmux/`, `ghostty/`, `kitty/`, or `vim/` can be pulled from or pushed back to their respective GitHub repositories at any time using `arch-dot subtrees` and `arch-dot push`.

---

## Subtree Remote & Documentation Inventory

| Directory | Remote Name | Upstream GitHub Repository | Branch | Dedicated Documentation |
| :--- | :--- | :--- | :--- | :--- |
| **`nvim/`** | `nvim-remote` | `https://github.com/MichaelWeissDEV/nvim-config.git` | `main` | [nvim-config.readthedocs.io](https://nvim-config.readthedocs.io/en/latest/) |
| **`tmux/`** | `tmux-remote` | `https://github.com/MichaelWeissDEV/tmux-config.git` | `main` | [tmux-config.readthedocs.io](https://tmux-config.readthedocs.io/en/latest/) |
| **`ghostty/`** | `ghostty-remote` | `https://github.com/MichaelWeissDEV/ghostty-config.git` | `main` | [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/) |
| **`kitty/`** | `kitty-remote` | `https://github.com/MichaelWeissDEV/kittiy-config.git` | `main` | [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/) |
| **`vim/`** | `vim-remote` | `https://github.com/MichaelWeissDEV/vim-config.git` | `main` | [vim-config.readthedocs.io](https://vim-config.readthedocs.io/en/latest/) |

---

## Managing Subtrees with `adot` & `scripts/update-subtrees.sh`

You can manage all subtrees through the unified **`adot`** (or `arch-dot` / `arch-dotfiles`) CLI program, which calls `~/git/dotfiles/scripts/update-subtrees.sh` under the hood.

### 1. View Subtree & System Status

```bash
adot status
# (or only subtrees: adot list subtrees / ~/git/dotfiles/scripts/update-subtrees.sh status)
```

Verifies that all 5 remotes are configured in your local Git repository, shows the latest local commit for each subtree, and checks all symlinks. Add `--fetch` (`adot status --fetch`) to also fetch the latest remote SHA hashes from GitHub.

### 2. Pull Updates from Upstream

```bash
# Update EVERYTHING (system packages + dotfiles + all 5 subtrees + plugins):
adot update

# Pull all 5 subtrees only (using squash merges):
adot update subtrees
# (or: adot subtrees / cfg-subtrees)

# Pull a single subtree:
adot update nvim
adot update tmux
adot update ghostty
adot update kitty
adot update vim
```

### 3. Push Local Changes Upstream

When you edit files inside `nvim/`, `tmux/`, `ghostty/`, `kitty/`, or `vim/`, commit them to `~/git/dotfiles` first, then push the subtree commits to the standalone GitHub repository:

```bash
# Push changes for an individual component:
adot push ghostty
adot push kitty
adot push vim
adot push nvim
adot push tmux

# Push changes across all 5 components:
adot push all
```

---

## Manual Git Subtree Commands

If you prefer running raw `git` commands without the helper script:

```bash
cd ~/git/dotfiles

# 1. Add upstream remotes (one-time setup):
git remote add nvim-remote    https://github.com/MichaelWeissDEV/nvim-config.git
git remote add tmux-remote    https://github.com/MichaelWeissDEV/tmux-config.git
git remote add ghostty-remote https://github.com/MichaelWeissDEV/ghostty-config.git
git remote add kitty-remote   https://github.com/MichaelWeissDEV/kittiy-config.git
git remote add vim-remote     https://github.com/MichaelWeissDEV/vim-config.git

# 2. Fetch and pull with squash:
git fetch nvim-remote main
git subtree pull --prefix=nvim nvim-remote main --squash -m "Update nvim subtree from upstream"

# 3. Push local commits back upstream:
git subtree push --prefix=nvim nvim-remote main
```

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
