# ghostty-config

A minimalist, high-performance **Ghostty** terminal configuration styled in the official **Catppuccin Mocha** palette with tasteful transparency, custom font metrics, and seamless integration with Neovim, tmux, and Hyprland.

:::{note}
**Part of the dotfiles ecosystem**: This is Michael Weiss' personal Ghostty configuration. It is built to be clean, self-contained, and beginner-friendly so anyone can clone it, understand every line, and use it as a reliable daily terminal on Linux or macOS.
:::

---

## Highlights

- 🎨 **Official Catppuccin Mocha Theme**: Base `#1e1e2e`, foreground `#cdd6f4`, selection `#89b4fa`, and block cursor in Rosewater `#f5e0dc`.
- 🪟 **Subtle Transparency**: Balanced `0.90` background opacity matching sibling Kitty and Foot configurations.
- 🔤 **JetBrainsMono Nerd Font**: Sized at `10.5pt` with balanced padding (`8px` horizontal and vertical).
- ⚡ **Zero Bloat**: No window decorations or bulky titlebars (`window-decoration = none`, `gtk-titlebar = false`), starts directly with Zsh.
- 🔄 **Ecosystem Consistency**: Configured to work seamlessly with Neovim splits, tmux pane switching, and Hyprland tiling.

---

## Table of Contents

```{toctree}
:maxdepth: 2
:caption: User Guide

installation
configuration
keybindings
faq
```

```{toctree}
:caption: Related documentation
:hidden:

Dotfiles (main hub) <https://michaelweiss-dotfiles.readthedocs.io/en/latest/>
Neovim (nvim-config) <https://nvim-config.readthedocs.io/en/latest/>
tmux (tmux-config) <https://tmux-config.readthedocs.io/en/latest/>
Kitty (kittiy-config) <https://kittiy-config.readthedocs.io/en/latest/>
Vim (vim-config) <https://vim-config.readthedocs.io/en/latest/>
```

---

## Quick Start

### Standalone Installation

```bash
git clone https://github.com/MichaelWeissDEV/ghostty-config.git ~/.config/ghostty
ghostty
```

### In the Dotfiles Repository

This repository is integrated as a **Git-Subtree** at `ghostty/` in `~/git/dotfiles` and linked directly to `~/.config/ghostty`:

```bash
# Update subtree from upstream:
~/git/dotfiles/scripts/update-subtrees.sh ghostty

# Push local changes back to upstream:
~/git/dotfiles/scripts/update-subtrees.sh push ghostty
```

---

## Connected Dotfiles Ecosystem

- **[Dotfiles Hub](https://michaelweiss-dotfiles.readthedocs.io/en/latest/)**: Central repository uniting desktop, window manager, and shell environments.
- **[nvim-config](https://nvim-config.readthedocs.io/en/latest/)**: Fast Neovim configuration with identical Catppuccin colors.
- **[tmux-config](https://tmux-config.readthedocs.io/en/latest/)**: Terminal multiplexer with truecolor and OSC 52 clipboard support.
- **[kittiy-config](https://kittiy-config.readthedocs.io/en/latest/)**: Alternative GPU-accelerated terminal with identical styling.
- **[vim-config](https://vim-config.readthedocs.io/en/latest/)**: Standalone Vim configuration.
