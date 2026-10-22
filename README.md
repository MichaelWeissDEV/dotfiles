# System Configurations (`~/.config`)

Zentrales Git-Repository für alle Tool- und Desktop-Konfigurationen unter `~/.config` (Arch Linux · Hyprland · Catppuccin Mocha).

## Enthaltene Konfigurationen

- **`zsh/`** – Zsh-Hauptkonfiguration (`zshrc`), modulare Aliases & FZF-Funktionen (`aliases.zsh`: `nv`, `v`, `fznv`, `fzv`, `y`, `tm`, `cfg-update`, …) sowie das minimale Prompt-Theme (`> `)
- **`nvim/`** – Neovim-Konfiguration (Git-Submodule: `MichaelWeissDEV/nvim-config`)
- **`vim/`** – Standalone Vim-Konfiguration (`vimrc`) im Catppuccin Mocha Design mit dynamischer Statuszeile (`NORMAL`/`INSERT`/`VISUAL`, `NUM:REL`/`NUM:ABS`) und Umschaltung zwischen relativen & absoluten Zeilennummern (`<Space>un`, `<Space>rn`, `<Space>n` oder `<F3>`)
- **`tmux/`** – Tmux-Konfiguration (Git-Submodule: `MichaelWeissDEV/tmux-config`)
- **`hypr/`** – Hyprland, Hyprlock, Powermenu & Askpass
- **`waybar/`** – Statusleiste
- **`foot/` & `kitty/`** – Terminal-Emulatoren
- **`fuzzel/`** – Application Launcher
- **`yazi/`** – Terminal-Dateimanager
- **`gtk-3.0/`, `gtk-4.0/`, `pcmanfm/`, `libfm/`** – Catppuccin Mocha GTK3/GTK4-Theming & PCManFM GUI-Dateimanager-Einstellungen

## Sauberes Repository (Whitelist `.gitignore`)

Die `.gitignore` arbeitet nach dem **Whitelist-Prinzip** (`*` wird standardmäßig ignoriert, nur die oben gelisteten Ordner sind explizit freigegeben). Dadurch werden Laufzeitdaten wie `mozilla/` (Firefox-Profile, SQLite-Datenbanken, Cookies), `dconf/` oder neu installierte Programme automatisch von Git ausgeschlossen.

## Auf einem neuen Arch-System einrichten & aktualisieren

```bash
# 1. Repository samt Submodulen (nvim, tmux) nach ~/.config klonen
git clone --recurse-submodules <REPO-URL> ~/.config

# 2. Komplettes Setup ausführen (Arch-Pakete, Submodule, Oh My Zsh + Plugins, Symlinks & Services)
~/.config/install.sh
```

### Weitere Befehle von `install.sh`

```bash
~/.config/install.sh install    # Komplettes Setup (Pakete, Submodule, Oh My Zsh, Symlinks, Services)
~/.config/install.sh update     # Systempakete, Dotfiles, Submodule & Zsh-Plugins aktualisieren (Alias: cfg-update)
~/.config/install.sh packages   # Nur benötigte Arch-Pakete via pacman nachinstallieren
~/.config/install.sh links      # Nur Symlinks (~/.zshrc, ~/.tmux.conf, ~/.vimrc) setzen (Alias: cfg-links)
```
