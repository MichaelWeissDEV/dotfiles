# Git Subtree Architecture

The core tools in this environment (**Neovim**, **tmux**, **Ghostty**, **Kitty**, and **Vim**) are maintained as independent GitHub repositories, but integrated into `dotfiles` using **Git Subtrees**.

---

## Why Git Subtrees over Submodules?

Traditional Git submodules frequently create friction:
- Fresh clones require `--recurse-submodules` or manual `git submodule update --init --recursive`.
- Repositories easily end up in a `detached HEAD` state when pulling changes.
- Automated CI/CD pipelines and deployment scripts can fail if credentials or external submodules fail to resolve.

**With Git Subtrees**:
- All code for all 5 tools is stored directly in the repository. A standard `git clone` gives you 100% of the functional codebase immediately.
- Edits made within `nvim/`, `tmux/`, `ghostty/`, `kitty/`, or `vim/` are committed alongside the rest of your dotfiles.
- When ready, changes can be cleanly pushed upstream to their respective standalone GitHub repositories using `git subtree push`.

---

## Subtree Remote Inventory

| Directory | Remote Name | Upstream Repository | Branch |
| :--- | :--- | :--- | :--- |
| **`nvim/`** | `nvim-remote` | `https://github.com/MichaelWeissDEV/nvim-config.git` | `main` |
| **`tmux/`** | `tmux-remote` | `https://github.com/MichaelWeissDEV/tmux-config.git` | `main` |
| **`ghostty/`** | `ghostty-remote` | `https://github.com/MichaelWeissDEV/ghostty-config.git` | `main` |
| **`kitty/`** | `kitty-remote` | `https://github.com/MichaelWeissDEV/kittiy-config.git` | `main` |
| **`vim/`** | `vim-remote` | `https://github.com/MichaelWeissDEV/vim-config.git` | `main` |

---

## Managing Subtrees with `scripts/update-subtrees.sh`

A dedicated helper script manages remote synchronization, pulling, and pushing.

### 1. View Subtree Status

```bash
~/git/dotfiles/scripts/update-subtrees.sh status
```

Verifies that all 5 remotes are configured in your local git repository and displays current tracking status.

### 2. Pull Updates from Upstream

```bash
# Pull all 5 subtrees (using squash merges):
~/git/dotfiles/scripts/update-subtrees.sh
# (or use the Zsh alias: cfg-subtrees)

# Pull a specific subtree:
~/git/dotfiles/scripts/update-subtrees.sh nvim
~/git/dotfiles/scripts/update-subtrees.sh tmux
~/git/dotfiles/scripts/update-subtrees.sh ghostty
~/git/dotfiles/scripts/update-subtrees.sh kitty
~/git/dotfiles/scripts/update-subtrees.sh vim
```

### 3. Push Local Changes Upstream

When you make changes to a tool inside `~/git/dotfiles/`, commit them locally to your branch, and then push them back to the upstream tool repository:

```bash
# Push changes for an individual component:
~/git/dotfiles/scripts/update-subtrees.sh push ghostty
~/git/dotfiles/scripts/update-subtrees.sh push kitty
~/git/dotfiles/scripts/update-subtrees.sh push vim
~/git/dotfiles/scripts/update-subtrees.sh push nvim
~/git/dotfiles/scripts/update-subtrees.sh push tmux

# Push changes across all components:
~/git/dotfiles/scripts/update-subtrees.sh push all
```

---

## Manual Git Commands

If you prefer using pure `git` commands without the helper script:

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

# 3. Push changes back upstream:
git subtree push --prefix=nvim nvim-remote main
```
