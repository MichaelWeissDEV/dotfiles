# Dotfiles (`~/git/dotfiles`)

Zentrales Git-Repository für alle Tool- und Desktop-Konfigurationen unter `~/git/dotfiles` (Arch Linux · Hyprland · Catppuccin Mocha).
Alle Konfigurationsordner werden per Symlink sauber nach `~/.config/<modul>` (sowie `~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`) verlinkt, sodass `~/.config` selbst frei von einem `.git`-Repository und Laufzeitdaten anderer Programme bleibt.

## Enthaltene Konfigurationen

- **`zsh/`** – Zsh-Hauptkonfiguration (`zshrc`), modulare Aliases & FZF-Funktionen (`aliases.zsh`: `nv`, `v`, `fznv`, `fzv`, `y`, `tm`, `dotfiles`, `cfg-update`, `cfg-links`, `cfg-subtrees`, …) sowie das minimale Prompt-Theme (`> `)
- **`nvim/`** – Neovim-Konfiguration (eingebunden als **Git-Subtree** aus `MichaelWeissDEV/nvim-config`)
- **`vim/`** – Standalone Vim-Konfiguration (`vimrc`) im Catppuccin Mocha Design mit dynamischer Statuszeile (`NORMAL`/`INSERT`/`VISUAL`, `NUM:REL`/`NUM:ABS`) und Umschaltung zwischen relativen & absoluten Zeilennummern (`<Space>un`, `<Space>rn`, `<Space>n` oder `<F3>`)
- **`tmux/`** – Tmux-Konfiguration (eingebunden als **Git-Subtree** aus `MichaelWeissDEV/tmux-config`)
- **`hypr/`** – Hyprland, Hyprlock, Powermenu & Askpass
- **`waybar/`** – Statusleiste
- **`foot/` & `kitty/`** – Terminal-Emulatoren
- **`fuzzel/`** – Application Launcher
- **`yazi/`** – Terminal-Dateimanager
- **`gtk-3.0/`, `gtk-4.0/`, `pcmanfm/`, `libfm/`** – Catppuccin Mocha GTK3/GTK4-Theming & PCManFM GUI-Dateimanager-Einstellungen

## Arbeiten mit den Git-Subtrees (`nvim` & `tmux`)

Da `nvim` und `tmux` als **Git-Subtrees** direkt im Repository liegen, sind alle Dateien unmittelbar im Haupt-Repository versioniert (kein `--recurse-submodules` beim Klonen nötig, kein Detached-HEAD).

```bash
# Beide Subtrees (nvim & tmux) von Upstream aktualisieren:
~/git/dotfiles/install.sh subtrees
# (oder über den Zsh-Alias: cfg-subtrees)

# Manuell per git subtree aktualisieren:
git -C ~/git/dotfiles subtree pull --prefix=nvim nvim-remote main --squash
git -C ~/git/dotfiles subtree pull --prefix=tmux tmux-remote main --squash

# Änderungen aus dotfiles zurück an das jeweilige Upstream-Repo pushen:
git -C ~/git/dotfiles subtree push --prefix=nvim nvim-remote main
git -C ~/git/dotfiles subtree push --prefix=tmux tmux-remote main
```

## Auf einem neuen Arch-System einrichten & aktualisieren

```bash
# 1. Repository nach ~/git/dotfiles klonen
mkdir -p ~/git
git clone <REPO-URL> ~/git/dotfiles

# 2. Nur Symlinks nach ~/.config und ~ setzen:
~/git/dotfiles/install-links.sh

# ODER: Komplettes Setup ausführen (Arch-Pakete, Subtree-Remotes, Oh My Zsh + Plugins, Symlinks & Services):
~/git/dotfiles/install.sh
```

### Weitere Befehle von `install.sh`

```bash
~/git/dotfiles/install.sh install    # Komplettes Setup (Pakete, Subtrees, Oh My Zsh, Symlinks, Services)
~/git/dotfiles/install.sh update     # Systempakete, Dotfiles, Subtrees & Zsh-Plugins aktualisieren (Alias: cfg-update)
~/git/dotfiles/install.sh subtrees   # Git-Subtrees (nvim & tmux) von Upstream aktualisieren (Alias: cfg-subtrees)
~/git/dotfiles/install.sh packages   # Nur benötigte Arch-Pakete via pacman nachinstallieren
~/git/dotfiles/install.sh links      # Nur Symlinks in ~/.config & ~ setzen (Alias: cfg-links / ./install-links.sh)
```
