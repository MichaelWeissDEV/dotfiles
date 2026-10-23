# Vim Configuration (`vim-config`)

Standalone **Vim**-Konfiguration (`vimrc`) ohne externe Plugin-Abhängigkeiten im offiziellen **Catppuccin Mocha (Pastel Theme)** Design – synchronisiert mit den wichtigsten Optionen und Tastenkombinationen aus `MichaelWeissDEV/nvim-config`.

---

## Features

- **Natives Catppuccin Mocha Farbschema:** Vollständige Pastell-Farbpalette (`#1e1e2e` Base, `#cdd6f4` Text, `#89b4fa` Blue, `#cba6f7` Mauve, `#a6e3a1` Green, `#fab387` Peach) ohne externe Plugins.
- **Dynamische Statuszeile:** Zeigt den aktuellen Modus farbig hervorgehoben (`NORMAL`, `INSERT`, `VISUAL`, `REPLACE`, `COMMAND`), Dateiname, Änderungsstatus (`[+]`), aktuellen Zeilennummern-Modus (`NUM:REL` / `NUM:ABS` / `NUM:OFF`), Dateityp, Encoding und Cursor-Position.
- **Schneller Zeilennummern-Toggle (Relativ ↔ Absolut):**
  - `<Space>un`, `<Space>rn`, `<Space>n` oder `<F3>`: Schaltet sofort zwischen relativen (Hybrid) und absoluten Zeilennummern um.
  - `<Space>uN`: Schaltet Zeilennummern komplett an/aus.
- **XDG-Sauberkeit:** Keine `.swp`- oder Backup-Dateien im Arbeitsverzeichnis; Persistent-Undo (`~/.local/state/vim/undo`) und `viminfo` (`~/.local/state/vim/viminfo`) liegen sauber unter `~/.local/state/vim`.
- **Mit Neovim synchronisierte Keymaps (`Leader = <Space>`):**
  - `CTRL + h/j/k/l`: Zwischen Splits navigieren
  - `<Space>wv` / `<Space>ws` / `<Space>wc` / `<Space>we`: Fenster vertikal/horizontal teilen, schließen, angleichen
  - `SHIFT + H` / `SHIFT + L` / `<Space>bd`: Zwischen Buffern wechseln / Buffer schließen
  - `<Space>y` / `<Space>Y`: In die System-Zwischenablage (`+`) kopieren
  - `<Space>uw` / `<Space>ul`: Zeilenumbruch (`wrap`) bzw. unsichtbare Zeichen (`list`) umschalten

---

## Installation

### 1. Standalone (`~/.config/vim` & `~/.vimrc`)

```bash
git clone https://github.com/MichaelWeissDEV/vim-config.git ~/.config/vim
ln -sfn ~/.config/vim/vimrc ~/.vimrc
mkdir -p ~/.local/state/vim/undo
```

### 2. Als Git-Subtree im Dotfiles-Repository (`~/git/dotfiles`)

Dieses Repository ist als **Git-Subtree** unter `vim/` in `~/git/dotfiles` eingebunden und wird per Symlink nach `~/.config/vim` sowie `~/.vimrc` verlinkt:

```bash
# Remote hinzufügen (einmalig):
git remote add vim-remote https://github.com/MichaelWeissDEV/vim-config.git

# Subtree von Upstream aktualisieren:
git fetch vim-remote main
git subtree pull --prefix=vim vim-remote main --squash -m "Update vim subtree from upstream"

# Lokale Änderungen aus ~/git/dotfiles/vim zurück nach Upstream pushen:
git subtree push --prefix=vim vim-remote main
```
*(Alternativ über das Dotfiles-Hilfsskript: `~/git/dotfiles/scripts/update-subtrees.sh vim` bzw. `~/git/dotfiles/scripts/update-subtrees.sh push vim`.)*
