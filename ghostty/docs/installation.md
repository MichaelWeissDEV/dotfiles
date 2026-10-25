# Installation

This guide walks you through installing the **Ghostty** terminal emulator, securing the required font, and placing this configuration on your system.

---

## Prerequisites

1. **Ghostty terminal emulator**: Ghostty 1.0 or newer.
2. **Nerd Font**: `JetBrainsMonoNL Nerd Font` (`ttf-jetbrains-mono-nerd`) for icons, status indicators, and clean ligature-free code rendering.
3. **Shell**: `zsh` is configured as the default command in this setup (can be adjusted to `bash` or `fish` if preferred).

---

## Installing Ghostty

### Arch Linux

```bash
sudo pacman -Syu --needed ghostty ttf-jetbrains-mono-nerd zsh
```

### macOS

Using Homebrew:

```bash
brew install --cask ghostty font-jetbrains-mono-nerd-font
```

### Ubuntu / Debian

Follow official instructions from the Ghostty release page or repository:

```bash
# Verify availability or download the .deb package:
sudo dpkg -i ghostty_*.deb
sudo apt-get install -f
```

---

## Deploying the Configuration

### Route A: Standalone Clone

Clone the repository directly into your user's XDG configuration directory:

```bash
git clone https://github.com/MichaelWeissDEV/ghostty-config.git ~/.config/ghostty
```

If you already have a `~/.config/ghostty` folder, create a backup first:

```bash
mv ~/.config/ghostty ~/.config/ghostty.bak
git clone https://github.com/MichaelWeissDEV/ghostty-config.git ~/.config/ghostty
```

### Route B: As Part of the Arch Dotfiles Hub

If you are using the full [Arch Dotfiles Hub](https://arch-dotfiles.readthedocs.io/en/latest/) (`~/git/dotfiles`), Ghostty is already embedded as a Git Subtree and automatically symlinked to `~/.config/ghostty`:

```bash
# Link or update via the central CLI program (adot / arch-dot / arch-dotfiles):
adot links
adot update ghostty
# or update the entire ecosystem:
adot update
```

---

## Verification

Launch Ghostty from your application launcher (e.g. `fuzzel`, `rofi`, or terminal):

```bash
ghostty
```

Check the active configuration:

1. The window should appear with no native titlebars or borders.
2. The background should have a subtle 10% transparency (`0.90` opacity) with the dark Catppuccin Mocha slate tone (`#1e1e2e`).
3. The cursor should be an unblinking solid block in Rosewater (`#f5e0dc`).

---

## Rollback & Uninstall

To remove this configuration:

```bash
rm -rf ~/.config/ghostty
# Restore previous backup if applicable:
[ -d ~/.config/ghostty.bak ] && mv ~/.config/ghostty.bak ~/.config/ghostty
```
