# Installation

This guide covers installing the **Kitty** terminal emulator, securing font requirements, and deploying this configuration.

---

## Prerequisites

1. **Kitty terminal emulator**: Version 0.28 or newer.
2. **Nerd Font**: `JetBrainsMonoNL Nerd Font` (`ttf-jetbrains-mono-nerd`) for status icons, Neovim file tree symbols, Powerline glyphs, and ligature-free code rendering.
3. **Shell**: Configured to spawn `/usr/bin/zsh`.

---

## Installing Kitty

### Arch Linux

```bash
sudo pacman -Syu --needed kitty ttf-jetbrains-mono-nerd zsh
```

### macOS

Using Homebrew:

```bash
brew install --cask kitty font-jetbrains-mono-nerd-font
```

### Debian / Ubuntu

```bash
sudo apt-get update
sudo apt-get install -y kitty fonts-jetbrains-mono zsh
```

---

## Deploying the Configuration

### Route A: Standalone Setup

Clone the repository directly into your XDG configuration directory:

```bash
# Backup any existing configuration
[ -d ~/.config/kitty ] && mv ~/.config/kitty ~/.config/kitty.bak

# Clone kitty-config
git clone https://github.com/MichaelWeissDEV/kitty-config.git ~/.config/kitty
```

### Route B: Inside the Arch Dotfiles Hub

In the parent [Arch Dotfiles Hub](https://arch-dotfiles.readthedocs.io/en/latest/) (`~/git/dotfiles`), Kitty is managed as a Git Subtree and linked automatically:

```bash
# Link or update via the central CLI program (adot / arch-dot / arch-dotfiles):
adot links
adot update kitty
# or update the entire ecosystem:
adot update
```

---

## Verification

Launch Kitty from your terminal or desktop launcher:

```bash
kitty
```

Verify visual characteristics:
1. Terminal background renders with `0.90` opacity and Catppuccin Mocha slate tone (`#1e1e2e`).
2. An unblinking Rosewater block cursor appears.
3. Opening multiple tabs (<kbd>Ctrl+Shift+T</kbd>) renders the Catppuccin Powerline tab bar.

---

## Rollback & Uninstall

```bash
rm -rf ~/.config/kitty
[ -d ~/.config/kitty.bak ] && mv ~/.config/kitty.bak ~/.config/kitty
```
