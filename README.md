# Dotfiles (`~/git/dotfiles`)

Zentrales Git-Repository für alle Tool- und Desktop-Konfigurationen unter `~/git/dotfiles` (Arch Linux · Hyprland · Catppuccin Mocha).
Alle Konfigurationsordner werden per Symlink sauber nach `~/.config/<modul>` (sowie `~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`) verlinkt, sodass `~/.config` selbst frei von einem `.git`-Repository und Laufzeitdaten anderer Programme bleibt.

---

## Enthaltene Konfigurationen & Ordnerstruktur

| Ordner | Beschreibung | Ziel-Symlink(s) |
| :--- | :--- | :--- |
| **`scripts/`** | Installations-, Symlink-, Subtree-Update- & Wallpaper-Repo-Skripte (`install.sh`, `install-links.sh`, `install-wallpapers.sh`, `update-subtrees.sh`) | – |
| **`zsh/`** | Zsh-Hauptkonfiguration (`zshrc`), modulare Aliases & FZF-Funktionen (`aliases.zsh`: `nv`, `v`, `fznv`, `fzv`, `y`, `tm`, `dotfiles`, `cfg-update`, `cfg-links`, `cfg-subtrees`, `cfg-wallpapers`) sowie minimales Prompt-Theme (`> `) | `~/.config/zsh`, `~/.zshrc`, `~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme` |
| **`nvim/`** | Neovim-Konfiguration (**Git-Subtree**: `MichaelWeissDEV/nvim-config`) | `~/.config/nvim` |
| **`tmux/`** | Tmux-Konfiguration (**Git-Subtree**: `MichaelWeissDEV/tmux-config`) | `~/.config/tmux`, `~/.tmux.conf` |
| **`vim/`** | Standalone Vim-Konfiguration (`vimrc`, **Git-Subtree**: `MichaelWeissDEV/vim-config`) im Catppuccin Mocha Design mit dynamischer Statuszeile (`NORMAL`/`INSERT`/`VISUAL`, `NUM:REL`/`NUM:ABS`) und Zeilennummern-Toggle (`<Space>un`, `<Space>rn`, `<Space>n`, `<F3>`) | `~/.config/vim`, `~/.vimrc` |
| **`ghostty/`** | Ghostty Terminal-Konfiguration (**Git-Subtree**: `MichaelWeissDEV/ghostty-config`) im Catppuccin Mocha Farbschema (transparent `0.90`, `JetBrainsMono Nerd Font`) | `~/.config/ghostty` |
| **`kitty/`** | Kitty Terminal-Konfiguration (**Git-Subtree**: `MichaelWeissDEV/kittiy-config`) im Catppuccin Mocha Farbschema (transparent `0.90`, `JetBrainsMono Nerd Font`) | `~/.config/kitty` |
| **`foot/`** | Leichtgewichtiger Wayland-Terminal-Emulator im Catppuccin Mocha Farbschema (transparent `0.90`, `JetBrainsMono Nerd Font`) | `~/.config/foot` |
| **`hypr/`** | Hyprland (inkl. monitorübergreifendem Fensterwechsel, Sprung-Positionen/Slots `1–10`/`F1–F4` & `windowswitcher.sh`), Hyprlock, Hyprpaper, Powermenu & Askpass | `~/.config/hypr` |
| **`wallpaper/`** | Wallpaper-Switcher für Hyprland (hyprpaper) mit Default- & Monitor-Zuweisung, Fuzzel-TUI (`SUPER + SHIFT + W`) & CLI (`wallpaper`) | `~/.config/wallpaper`, `~/.local/bin/wallpaper` |
| **`pictures/`** | Privates Wallpaper-Repository (optional, per `.gitignore` ausgeschlossen; nicht im öffentlichen Dotfiles-Repo) | – |
| **`waybar/`** | Waybar Statusleiste (`config.jsonc`, `style.css`, `power_menu.xml`) | `~/.config/waybar` |
| **`fuzzel/`** | Wayland Application Launcher | `~/.config/fuzzel` |
| **`yazi/`** | Terminal-Dateimanager inkl. `catppuccin-mocha.yazi` Flavor | `~/.config/yazi` |
| **`gtk-3.0/`, `gtk-4.0/`, `pcmanfm/`, `libfm/`** | Catppuccin Mocha GTK3/GTK4-Theming & PCManFM GUI-Dateimanager-Einstellungen | `~/.config/gtk-3.0`, `~/.config/gtk-4.0`, `~/.config/pcmanfm`, `~/.config/libfm` |

---

## Verwendete Git-Repositories

Das Setup bezieht folgende externe Git-Repositories (als Subtree, für Oh My Zsh oder optional als privates Wallpaper-Repo):

### 1. Eingebettete Git-Subtrees (direkt im Repository versioniert)
| Subtree-Pfad | Remote-Name | Git-Repository URL | Branch |
| :--- | :--- | :--- | :--- |
| **`nvim/`** | `nvim-remote` | `https://github.com/MichaelWeissDEV/nvim-config.git` | `main` |
| **`tmux/`** | `tmux-remote` | `https://github.com/MichaelWeissDEV/tmux-config.git` | `main` |
| **`ghostty/`** | `ghostty-remote` | `https://github.com/MichaelWeissDEV/ghostty-config.git` | `main` |
| **`kitty/`** | `kitty-remote` | `https://github.com/MichaelWeissDEV/kittiy-config.git` | `main` |
| **`vim/`** | `vim-remote` | `https://github.com/MichaelWeissDEV/vim-config.git` | `main` |

### 2. Externe Git-Repositories (lokal unter `~/.oh-my-zsh` geklont durch `scripts/install.sh`)
| Komponente | Zielpfad | Git-Repository URL |
| :--- | :--- | :--- |
| **Oh My Zsh** | `~/.oh-my-zsh` | `https://github.com/ohmyzsh/ohmyzsh.git` |
| **zsh-autosuggestions** | `~/.oh-my-zsh/custom/plugins/zsh-autosuggestions` | `https://github.com/zsh-users/zsh-autosuggestions.git` |
| **zsh-syntax-highlighting** | `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting` | `https://github.com/zsh-users/zsh-syntax-highlighting.git` |

### 3. Privates Wallpaper-Repository (optional, nicht Teil dieses Repos)
| Komponente | Zielpfad | Git-Repository URL | Hinweis |
| :--- | :--- | :--- | :--- |
| **Wallpapers** | `~/git/dotfiles/pictures` | privates Repo (URL wird bewusst nicht veröffentlicht) | per `.gitignore` ausgeschlossen (Urheberrecht); Einrichtung mit `scripts/install-wallpapers.sh <git-url>` |

---

## Git-Subtrees (`nvim`, `tmux`, `ghostty`, `kitty` & `vim`) verwalten & aktualisieren

Da `nvim`, `tmux`, `ghostty`, `kitty` und `vim` als **Git-Subtrees** eingebunden sind, befinden sich alle Dateien direkt in diesem Repository (kein `--recurse-submodules` beim Klonen nötig, kein Detached-HEAD), können aber jederzeit einzeln mit ihren eigenen GitHub-Repositories synchronisiert werden.

### Per Skript verwalten (`scripts/update-subtrees.sh`)

```bash
# Status aller 5 Subtrees & Remotes anzeigen:
~/git/dotfiles/scripts/update-subtrees.sh status

# Alle 5 Subtrees (nvim, tmux, ghostty, kitty & vim) von Upstream pullen (Standard):
~/git/dotfiles/scripts/update-subtrees.sh
# (oder kurz über den Zsh-Alias: cfg-subtrees)

# Nur einen einzelnen Subtree von Upstream aktualisieren:
~/git/dotfiles/scripts/update-subtrees.sh nvim
~/git/dotfiles/scripts/update-subtrees.sh tmux
~/git/dotfiles/scripts/update-subtrees.sh ghostty
~/git/dotfiles/scripts/update-subtrees.sh kitty
~/git/dotfiles/scripts/update-subtrees.sh vim

# Lokale Änderungen aus einem Subtree-Ordner zurück in das jeweilige GitHub-Repo pushen:
~/git/dotfiles/scripts/update-subtrees.sh push ghostty
~/git/dotfiles/scripts/update-subtrees.sh push kitty
~/git/dotfiles/scripts/update-subtrees.sh push vim
~/git/dotfiles/scripts/update-subtrees.sh push nvim
~/git/dotfiles/scripts/update-subtrees.sh push tmux
~/git/dotfiles/scripts/update-subtrees.sh push all

# Git-Remotes (nvim-remote, tmux-remote, ghostty-remote, kitty-remote, vim-remote) prüfen/anlegen:
~/git/dotfiles/scripts/update-subtrees.sh setup
```

### Im Zweifel manuell per `git subtree` aktualisieren

Falls du die Subtrees ohne Skript direkt mit Git verwalten oder im Fehlerfall manuell synchronisieren möchtest:

```bash
cd ~/git/dotfiles

# 1. Sicherstellen, dass alle 5 Remotes eingetragen sind (einmalig nach frischem Klonen):
git remote add nvim-remote    https://github.com/MichaelWeissDEV/nvim-config.git
git remote add tmux-remote    https://github.com/MichaelWeissDEV/tmux-config.git
git remote add ghostty-remote https://github.com/MichaelWeissDEV/ghostty-config.git
git remote add kitty-remote   https://github.com/MichaelWeissDEV/kittiy-config.git
git remote add vim-remote     https://github.com/MichaelWeissDEV/vim-config.git

# 2. Updates von den Upstream-Repositories holen und per --squash mergen:
git fetch nvim-remote main    && git subtree pull --prefix=nvim    nvim-remote    main --squash -m "Update nvim subtree from upstream"
git fetch tmux-remote main    && git subtree pull --prefix=tmux    tmux-remote    main --squash -m "Update tmux subtree from upstream"
git fetch ghostty-remote main && git subtree pull --prefix=ghostty ghostty-remote main --squash -m "Update ghostty subtree from upstream"
git fetch kitty-remote main   && git subtree pull --prefix=kitty   kitty-remote   main --squash -m "Update kitty subtree from upstream"
git fetch vim-remote main     && git subtree pull --prefix=vim     vim-remote     main --squash -m "Update vim subtree from upstream"

# 3. Lokale Commits aus ~/git/dotfiles zurück an das jeweilige Upstream-Repo pushen:
git subtree push --prefix=nvim    nvim-remote    main
git subtree push --prefix=tmux    tmux-remote    main
git subtree push --prefix=ghostty ghostty-remote main
git subtree push --prefix=kitty   kitty-remote   main
git subtree push --prefix=vim     vim-remote     main
```

---

## Wallpaper-Switcher (`wallpaper/`)

Der Wallpaper-Switcher verwaltet Hintergrundbilder über **hyprpaper** – mit einem **Default für alle Bildschirme** und **eigenen Wallpapers pro Monitor** (z. B. Zweit- oder Drittschirm).

```bash
# Fuzzel-TUI: erst Ziel (alle oder ein Monitor), dann Wallpaper wählen
wallpaper

# Verfügbare Wallpapers (★ = Default, ● = Monitor-Override)
wallpaper list

# Default für alle Bildschirme ohne eigenen Override setzen
wallpaper set forest.png

# Eigenes Wallpaper für einen Monitor (z. B. Drittschirm)
wallpaper set ocean.png --monitor DP-1

# Überall dasselbe Wallpaper setzen und alle Overrides löschen
wallpaper set city.png --all

# Override wieder entfernen (nutzt danach den Default)
wallpaper monitor DP-1 default

# Aktuelle Belegung anzeigen
wallpaper current
```

### Privates Wallpaper-Repository (Urheberrecht)

Die Bilder liegen **nicht** im öffentlichen Dotfiles-Repo, sondern in `~/git/dotfiles/pictures/`. Das Verzeichnis ist per `.gitignore` ausgeschlossen und wird separat als privates Git-Repo geklont – bewusst **kein Git-Submodul**, damit die private URL nicht in `.gitmodules` steht.

```bash
# Einmalig klonen (URL deines privaten Repos)
~/git/dotfiles/scripts/install-wallpapers.sh <git-url>

# Oder manuell
cd ~/git/dotfiles
git clone <git-url> pictures

# Aktualisieren
~/git/dotfiles/scripts/install-wallpapers.sh --update
```

Das Dotfiles-Repo bleibt sauber; `pictures/` erscheint nicht in `git status`.

> **Achtung:** `pictures/` ist absichtlich ignoriert. Ein `git clean -fdx` im Dotfiles-Repo würde das private Wallpaper-Repo löschen. Vorher committen und pushen.

### Eigene Wallpapers hinzufügen

**Standardordner:** `~/git/dotfiles/pictures` (Unterordner werden rekursiv gelesen). Bilder erscheinen sofort in der TUI und in `wallpaper list` – ein Neustart ist nicht nötig.

```bash
cp ~/Downloads/mein-bild.jpg ~/git/dotfiles/pictures/

# Oder bequem über das Tool (mit --set direkt als Default übernehmen)
wallpaper add ~/Downloads/mein-bild.jpg --set
```

Neue Bilder im privaten Repo committen:

```bash
git -C ~/git/dotfiles/pictures add .
git -C ~/git/dotfiles/pictures commit -m "Add wallpapers"
git -C ~/git/dotfiles/pictures push
```

Weitere Ordner können in `~/.config/wallpaper/wallpaper.conf` unter `WALLPAPER_DIRS` ergänzt werden. Mit `wallpaper dirs` siehst du alle aktiven Quellen.

- **Konfiguration:** `~/.config/wallpaper/wallpaper.conf` (Suchordner, Fit-Modus `cover|contain|tile|fill`, Benachrichtigungen).
- **Gespeicherter Zustand:** `~/.local/state/wallpaper/state` (Default + Monitor-Overrides; bleibt aus dem Git-Repo heraus).
- **Tastenkürzel:** `SUPER + SHIFT + W` oder CLI `wallpaper` (kein Waybar-Symbol).
- **Autostart:** Hyprland wendet die gespeicherte Belegung beim Start automatisch an; neu angeschlossene Monitore erhalten den Default.
- **Details:** [`wallpaper/README.md`](wallpaper/README.md)

---

## Enthaltene Arch Linux Pakete (`pacman`)

Das Skript `scripts/install.sh` (bzw. `scripts/install.sh packages`) installiert über die offiziellen Arch Linux Repositories (`pacman -Syu --needed`) folgende Pakete:

### Hyprland & Wayland Desktop
- `hyprland` – Wayland Tiling Compositor
- `hyprpaper` – Wallpaper-Daemon mit IPC (Default- & Monitor-Wallpapers)
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
~/git/dotfiles/scripts/install.sh subtrees   # Alle 5 Git-Subtrees (nvim, tmux, ghostty, kitty & vim) aktualisieren
~/git/dotfiles/scripts/install.sh packages   # Nur benötigte Arch-Pakete via pacman installieren
~/git/dotfiles/scripts/install.sh links      # Nur Symlinks in ~/.config & ~ setzen (Alias: cfg-links)
~/git/dotfiles/scripts/install.sh wallpapers <git-url>  # Privates Wallpaper-Repo klonen/aktualisieren

# Symlink-Kurzskript (scripts/install-links.sh)
~/git/dotfiles/scripts/install-links.sh      # Setzt direkt alle Symlinks in ~/.config & ~ (Alias: cfg-links)

# Subtree-Updater (scripts/update-subtrees.sh)
~/git/dotfiles/scripts/update-subtrees.sh              # Alle 5 Subtrees (nvim, tmux, ghostty, kitty & vim) pullen (Alias: cfg-subtrees)
~/git/dotfiles/scripts/update-subtrees.sh status       # Status & Remote-URLs aller 5 Subtrees anzeigen
~/git/dotfiles/scripts/update-subtrees.sh <modul>      # Einzelnen Subtree pullen (nvim|tmux|ghostty|kitty|vim)
~/git/dotfiles/scripts/update-subtrees.sh push <modul> # Einzelnen Subtree nach Upstream pushen (nvim|tmux|ghostty|kitty|vim|all)

# Privates Wallpaper-Repo (scripts/install-wallpapers.sh)
~/git/dotfiles/scripts/install-wallpapers.sh <git-url>  # Einmalig klonen (Alias: cfg-wallpapers)
~/git/dotfiles/scripts/install-wallpapers.sh --update   # Vorhandenes Repo aktualisieren
```
