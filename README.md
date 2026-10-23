# Ghostty Configuration (`ghostty-config`)

Minimalistische, schnelle **Ghostty**-Konfiguration im offiziellen **Catppuccin Mocha (Pastel Theme)** Farbschema.
Abgestimmt auf Arch Linux, Hyprland, Zsh (Oh My Zsh), Tmux und Neovim.

---

## Features

- **Farbschema:** Offizielles **Catppuccin Mocha** (`#1e1e2e` Base, `#cdd6f4` Text, `#89b4fa` Pastel Blue Selection, `#f5e0dc` Rosewater Block-Cursor)
- **Transparenz:** Dezente Hintergrund-Transparenz (`background-opacity = 0.90`), exakt abgestimmt auf `kitty` und `foot`
- **Schriftart:** `JetBrainsMono Nerd Font` (`10.5pt`)
- **Minimalistisches Fenster-Layout:**
  - Keine Titelleiste / Fensterdekoration (`window-decoration = none`, `gtk-titlebar = false`)
  - Ausbalanciertes Padding (`8px`)
  - Startet direkt mit `/usr/bin/zsh`
  - Schließen ohne Sicherheitsabfrage (`confirm-close-surface = false`)

---

## Installation

### 1. Standalone (`~/.config/ghostty`)

```bash
git clone https://github.com/MichaelWeissDEV/ghostty-config.git ~/.config/ghostty
```

### 2. Als Git-Subtree im Dotfiles-Repository (`~/git/dotfiles`)

Dieses Repository ist als **Git-Subtree** unter `ghostty/` in `~/git/dotfiles` eingebunden und wird per Symlink nach `~/.config/ghostty` verlinkt:

```bash
# Remote hinzufügen (einmalig):
git remote add ghostty-remote https://github.com/MichaelWeissDEV/ghostty-config.git

# Subtree von Upstream aktualisieren:
git fetch ghostty-remote main
git subtree pull --prefix=ghostty ghostty-remote main --squash -m "Update ghostty subtree from upstream"

# Lokale Änderungen aus ~/git/dotfiles/ghostty zurück nach Upstream pushen:
git subtree push --prefix=ghostty ghostty-remote main
```
*(Alternativ über das Dotfiles-Hilfsskript: `~/git/dotfiles/scripts/update-subtrees.sh ghostty` bzw. `~/git/dotfiles/scripts/update-subtrees.sh push ghostty`.)*
