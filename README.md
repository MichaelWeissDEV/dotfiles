# Kitty Configuration (`kittiy-config`)

Minimalistische, GPU-beschleunigte **Kitty**-Konfiguration im offiziellen **Catppuccin Mocha (Pastel Theme)** Farbschema.
Abgestimmt auf Arch Linux, Hyprland, Zsh (Oh My Zsh), Tmux und Neovim.

---

## Features

- **Farbschema:** Offizielles **Catppuccin Mocha** (`#1e1e2e` Base, `#cdd6f4` Text, `#89b4fa` Pastel Blue Selection, `#f5e0dc` Rosewater Block-Cursor, Powerline-Tabs)
- **Transparenz:** Dezente Hintergrund-Transparenz (`background_opacity 0.90`, `dynamic_background_opacity yes`), exakt abgestimmt auf `ghostty` und `foot`
- **Schriftart:** `JetBrainsMono Nerd Font` (`10.5pt`)
- **Minimalistisches Verhalten:**
  - Startet direkt mit `/usr/bin/zsh`
  - `window_padding_width 8`
  - Keine Audio-Glocke (`enable_audio_bell no`)
  - Schließen ohne Rückfrage (`confirm_os_window_close 0`)

---

## Installation

### 1. Standalone (`~/.config/kitty`)

```bash
git clone https://github.com/MichaelWeissDEV/kittiy-config.git ~/.config/kitty
```

### 2. Als Git-Subtree im Dotfiles-Repository (`~/git/dotfiles`)

Dieses Repository ist als **Git-Subtree** unter `kitty/` in `~/git/dotfiles` eingebunden und wird per Symlink nach `~/.config/kitty` verlinkt:

```bash
# Remote hinzufügen (einmalig):
git remote add kitty-remote https://github.com/MichaelWeissDEV/kittiy-config.git

# Subtree von Upstream aktualisieren:
git fetch kitty-remote main
git subtree pull --prefix=kitty kitty-remote main --squash -m "Update kitty subtree from upstream"

# Lokale Änderungen aus ~/git/dotfiles/kitty zurück nach Upstream pushen:
git subtree push --prefix=kitty kitty-remote main
```
*(Alternativ über das Dotfiles-Hilfsskript: `~/git/dotfiles/scripts/update-subtrees.sh kitty` bzw. `~/git/dotfiles/scripts/update-subtrees.sh push kitty`.)*
