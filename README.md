# Dotfiles (`~/git/dotfiles`)

Zentrales Git-Repository für alle Tool- und Desktop-Konfigurationen unter `~/git/dotfiles` (Arch Linux · Hyprland · Catppuccin Mocha).
Alle Konfigurationsordner werden per Symlink sauber nach `~/.config/<modul>` (sowie `~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`) verlinkt, sodass `~/.config` selbst frei von einem `.git`-Repository und Laufzeitdaten anderer Programme bleibt.

---

## Enthaltene Konfigurationen & Ordnerstruktur

| Ordner | Beschreibung | Ziel-Symlink(s) |
| :--- | :--- | :--- |
| **`scripts/`** | Installations-, Symlink- und Subtree-Update-Skripte (`install.sh`, `install-links.sh`, `update-subtrees.sh`) | – |
| **`zsh/`** | Zsh-Hauptkonfiguration (`zshrc`), modulare Aliases & FZF-Funktionen (`aliases.zsh`: `nv`, `v`, `fznv`, `fzv`, `y`, `tm`, `dotfiles`, `cfg-update`, `cfg-links`, `cfg-subtrees`) sowie minimales Prompt-Theme (`> `) | `~/.config/zsh`, `~/.zshrc`, `~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme` |
| **`nvim/`** | Neovim-Konfiguration (**Git-Subtree**: `MichaelWeissDEV/nvim-config`) | `~/.config/nvim` |
| **`tmux/`** | Tmux-Konfiguration (**Git-Subtree**: `MichaelWeissDEV/tmux-config`) | `~/.config/tmux`, `~/.tmux.conf` |
| **`vim/`** | Standalone Vim-Konfiguration (`vimrc`) im Catppuccin Mocha Design mit dynamischer Statuszeile (`NORMAL`/`INSERT`/`VISUAL`, `NUM:REL`/`NUM:ABS`) und Zeilennummern-Toggle (`<Space>un`, `<Space>rn`, `<Space>n`, `<F3>`) | `~/.config/vim`, `~/.vimrc` |
| **`hypr/`** | Hyprland, Hyprlock, Powermenu & Askpass | `~/.config/hypr` |
| **`waybar/`** | Waybar Statusleiste (`config.jsonc`, `style.css`, `power_menu.xml`) | `~/.config/waybar` |
| **`foot/`, `ghostty/` & `kitty/`** | Terminal-Emulatoren im Catppuccin Mocha Farbschema (transparent `0.90`, `JetBrainsMono Nerd Font`) | `~/.config/foot`, `~/.config/ghostty`, `~/.config/kitty` |
| **`fuzzel/`** | Wayland Application Launcher | `~/.config/fuzzel` |
| **`yazi/`** | Terminal-Dateimanager inkl. `catppuccin-mocha.yazi` Flavor | `~/.config/yazi` |
| **`gtk-3.0/`, `gtk-4.0/`, `pcmanfm/`, `libfm/`** | Catppuccin Mocha GTK3/GTK4-Theming & PCManFM GUI-Dateimanager-Einstellungen | `~/.config/gtk-3.0`, `~/.config/gtk-4.0`, `~/.config/pcmanfm`, `~/.config/libfm` |

---

## Verwendete Git-Repositories

Das Setup bezieht folgende externe Git-Repositories (entweder direkt als Subtree im Repo oder beim Setup für Oh My Zsh):

### 1. Eingebettete Git-Subtrees (direkt im Repository versioniert)
| Subtree-Pfad | Remote-Name | Git-Repository URL | Branch |
| :--- | :--- | :--- | :--- |
| **`nvim/`** | `nvim-remote` | `https://github.com/MichaelWeissDEV/nvim-config.git` | `main` |
| **`tmux/`** | `tmux-remote` | `https://github.com/MichaelWeissDEV/tmux-config.git` | `main` |

### 2. Externe Git-Repositories (lokal unter `~/.oh-my-zsh` geklont durch `scripts/install.sh`)
| Komponente | Zielpfad | Git-Repository URL |
| :--- | :--- | :--- |
| **Oh My Zsh** | `~/.oh-my-zsh` | `https://github.com/ohmyzsh/ohmyzsh.git` |
| **zsh-autosuggestions** | `~/.oh-my-zsh/custom/plugins/zsh-autosuggestions` | `https://github.com/zsh-users/zsh-autosuggestions.git` |
| **zsh-syntax-highlighting** | `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting` | `https://github.com/zsh-users/zsh-syntax-highlighting.git` |

---

## Git-Subtrees (`nvim` & `tmux`) aktualisieren

Da `nvim` und `tmux` als **Git-Subtrees** eingebunden sind, befinden sich alle Dateien direkt in diesem Repository (kein `--recurse-submodules` beim Klonen nötig, kein Detached-HEAD).

### Per Skript aktualisieren (`scripts/update-subtrees.sh`)

```bash
# Beide Subtrees (nvim & tmux) von Upstream aktualisieren (Standard):
~/git/dotfiles/scripts/update-subtrees.sh
# (oder kurz über den Zsh-Alias: cfg-subtrees)

# Nur einen einzelnen Subtree aktualisieren:
~/git/dotfiles/scripts/update-subtrees.sh nvim
~/git/dotfiles/scripts/update-subtrees.sh tmux

# Lokale Änderungen aus nvim/ oder tmux/ zurück in das jeweilige Upstream-Repo pushen:
~/git/dotfiles/scripts/update-subtrees.sh push nvim
~/git/dotfiles/scripts/update-subtrees.sh push tmux
~/git/dotfiles/scripts/update-subtrees.sh push all

# Git-Remotes (nvim-remote, tmux-remote) prüfen bzw. initial anlegen:
~/git/dotfiles/scripts/update-subtrees.sh setup
```

### Im Zweifel manuell per `git subtree` aktualisieren

Falls du die Subtrees ohne Skript direkt mit Git verwalten oder im Fehlerfall manuell synchronisieren möchtest:

```bash
cd ~/git/dotfiles

# 1. Sicherstellen, dass die Remotes eingetragen sind (einmalig nach frischem Klonen):
git remote add nvim-remote https://github.com/MichaelWeissDEV/nvim-config.git
git remote add tmux-remote https://github.com/MichaelWeissDEV/tmux-config.git

# 2. Updates von den Upstream-Repositories holen und per --squash mergen:
git fetch nvim-remote main
git subtree pull --prefix=nvim nvim-remote main --squash -m "Update nvim subtree from upstream"

git fetch tmux-remote main
git subtree pull --prefix=tmux tmux-remote main --squash -m "Update tmux subtree from upstream"

# 3. Lokale Commits aus ~/git/dotfiles zurück an das Upstream-Repo pushen:
git subtree push --prefix=nvim nvim-remote main
git subtree push --prefix=tmux tmux-remote main

# 4. Falls ein Subtree komplett neu hinzugefügt werden soll (nur wenn Ordner noch nicht existiert):
git subtree add --prefix=nvim nvim-remote main --squash -m "Add nvim config as git subtree"
git subtree add --prefix=tmux tmux-remote main --squash -m "Add tmux config as git subtree"
```

---

## Enthaltene Arch Linux Pakete (`pacman`)

Das Skript `scripts/install.sh` (bzw. `scripts/install.sh packages`) installiert über die offiziellen Arch Linux Repositories (`pacman -Syu --needed`) folgende Pakete:

### Hyprland & Wayland Desktop
- `hyprland` – Wayland Tiling Compositor
- `hyprlock` – Sperrbildschirm für Hyprland
- `hypridle` – Idle-Management-Daemon für Hyprland
- `waybar` – Statusleiste für Wayland
- `fuzzel` – Application Launcher & dmenu-Ersatz (für Powermenu & Askpass)
- `xdg-desktop-portal-hyprland` – XDG Desktop Portal Backend für Screen-Sharing etc.
- `wl-clipboard` – Wayland Clipboard-Tools (`wl-copy`, `wl-paste`)
- `grim` & `slurp` – Screenshot-Werkzeuge für Wayland (Vollbild & Bereichsauswahl)
- `brightnessctl` – Steuerung der Bildschirmhelligkeit
- `power-profiles-daemon` – Energieprofil-Verwaltung (über D-Bus / Waybar steuerbar)

### Audio (PipeWire), Netzwerk & Bluetooth
- `pipewire`, `pipewire-alsa`, `pipewire-pulse`, `pipewire-jack`, `wireplumber`, `gst-plugin-pipewire`, `libpulse` – Kompletter PipeWire Audio-Stack
- `networkmanager` – Netzwerkverwaltung (inkl. `nmcli` & `nmtui`)
- `bluez` & `bluez-utils` – Bluetooth-Stack & CLI (`bluetoothctl`)

### Terminals & Shell-Umgebung
- `ghostty`, `kitty` & `foot` – Schnelle, GPU-beschleunigte bzw. leichtgewichtige Wayland-Terminal-Emulatoren
- `zsh` – Standard-Shell
- `tmux` – Terminal-Multiplexer

### Editoren & CLI-Werkzeuge
- `neovim` (`nvim`) & `vim` (`v`) – Terminal-Editoren
- `git` – Versionsverwaltung (inkl. `git subtree`)
- `fzf` – Interaktiver Fuzzy-Finder (für `fznv`, `fzv` & Zsh-History)
- `ripgrep` (`rg`) & `fd` – Schnelle Text- und Dateisuche (für Neovim Telescope/Picker & CLI)
- `jq` – JSON-Prozessor (u. a. für Waybar-Skripte)
- `wget` – Datei-Downloader
- `man-db` & `man-pages` – Handbuchseiten

### Dateimanager, Browser & Schriftarten
- `yazi` – Schneller Terminal-Dateimanager
- `pcmanfm` – Leichtgewichtiger GTK-Dateimanager
- `firefox` – Webbrowser
- `ttf-jetbrains-mono-nerd` & `noto-fonts` – Schriftarten inkl. Nerd-Font-Icons für Waybar, Neovim, Tmux & Yazi

---

## Installation & Verwendung (`scripts/`)

```bash
# 1. Repository nach ~/git/dotfiles klonen
mkdir -p ~/git
git clone <REPO-URL> ~/git/dotfiles

# 2. Nur Symlinks nach ~/.config und ~ setzen:
~/git/dotfiles/scripts/install-links.sh

# ODER: Komplettes System-Setup ausführen (Arch-Pakete, Subtrees, Oh My Zsh + Plugins, Symlinks & Services):
~/git/dotfiles/scripts/install.sh
```

### Übersicht aller Skript-Befehle

```bash
# Haupt-Installer & System-Updater (scripts/install.sh)
~/git/dotfiles/scripts/install.sh install    # Komplettes Setup (Pakete, Subtrees, Oh My Zsh, Symlinks, Services)
~/git/dotfiles/scripts/install.sh update     # Systempakete, Dotfiles, Subtrees & Zsh-Plugins aktualisieren (Alias: cfg-update)
~/git/dotfiles/scripts/install.sh subtrees   # Git-Subtrees (nvim & tmux) aktualisieren
~/git/dotfiles/scripts/install.sh packages   # Nur benötigte Arch-Pakete via pacman installieren
~/git/dotfiles/scripts/install.sh links      # Nur Symlinks in ~/.config & ~ setzen (Alias: cfg-links)

# Symlink-Kurzskript (scripts/install-links.sh)
~/git/dotfiles/scripts/install-links.sh      # Setzt direkt alle Symlinks in ~/.config & ~ (Alias: cfg-links)

# Subtree-Updater (scripts/update-subtrees.sh)
~/git/dotfiles/scripts/update-subtrees.sh           # Beide Subtrees (nvim & tmux) pullen (Alias: cfg-subtrees)
~/git/dotfiles/scripts/update-subtrees.sh nvim      # Nur nvim-Subtree pullen
~/git/dotfiles/scripts/update-subtrees.sh tmux      # Nur tmux-Subtree pullen
~/git/dotfiles/scripts/update-subtrees.sh push all  # Lokale Subtree-Änderungen nach Upstream pushen
```
