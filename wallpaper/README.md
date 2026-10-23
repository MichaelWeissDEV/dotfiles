# Wallpaper-Switcher – Catppuccin Mocha

Wechselt Hintergrundbilder unter Hyprland über **hyprpaper** – mit einem
**Default für alle Bildschirme** und **eigenen Wallpapers pro Monitor**
(z. B. Zweit- oder Drittschirm).

Die Wallpaper werden aus der privaten Bibliothek `~/git/dotfiles/pictures`
gelesen. Dieses Verzeichnis ist per `.gitignore` aus dem öffentlichen
Dotfiles-Repo ausgeschlossen (Urheberrecht) und wird separat als privates
Git-Repository geklont. Unterordner werden rekursiv durchsucht.

---

## Schnellstart

```bash
# Fuzzel-TUI: erst Ziel (alle oder ein Monitor), dann Wallpaper wählen
wallpaper

# Verfügbare Wallpapers anzeigen (★ = Default, ● = Monitor-Override)
wallpaper list

# Default für alle Bildschirme ohne eigenen Override setzen
wallpaper set forest.png

# Eigenes Wallpaper für einen Monitor (z. B. Drittschirm)
wallpaper set ocean.png --monitor DP-1

# Überall dasselbe Wallpaper setzen und alle Overrides löschen
wallpaper set city.png --all

# Override eines Monitors wieder entfernen (nutzt danach den Default)
wallpaper monitor DP-1 default

# Aktuelle Belegung anzeigen
wallpaper current
```

Beim Start von Hyprland wird die gespeicherte Belegung automatisch angewendet.
Ein neu angeschlossener Monitor erhält zunächst den Default.

---

## Befehle

| Befehl | Beschreibung |
| :--- | :--- |
| `wallpaper` | Fuzzel-TUI öffnen (Ziel + Wallpaper) |
| `wallpaper list [--monitor MON]` | Wallpapers auflisten (`--plain` nur Namen) |
| `wallpaper set <name\|pfad> [--monitor MON \| --all]` | Default bzw. Monitor-Override setzen |
| `wallpaper default [<name\|pfad>]` | Default anzeigen oder setzen |
| `wallpaper monitor <MON> [<name\|pfad>\|default]` | Monitor-Override anzeigen/setzen/entfernen |
| `wallpaper clear <MON> \| --all` | Override(s) entfernen |
| `wallpaper current` | Belegung und aktive Wallpapers pro Monitor |
| `wallpaper next` / `prev` | Nächstes/vorheriges Wallpaper |
| `wallpaper random [--monitor MON \| --all]` | Zufälliges Wallpaper |
| `wallpaper apply [--quiet] [--monitor MON]` | Gespeicherte Belegung anwenden |
| `wallpaper reload` | hyprpaper neu starten und Belegung anwenden |
| `wallpaper dirs` | Wallpaper-Ordner, Konfiguration und Status anzeigen |
| `wallpaper add <datei>... [--move] [--set]` | Bilder in die Bibliothek übernehmen |
| `wallpaper open` | Wallpaper-Ordner im Dateimanager öffnen |
| `wallpaper doctor` | Installation, Monitore und Status prüfen |

### Ziel-Semantik

- **Default** (`wallpaper set X` bzw. `wallpaper default X`): gilt für alle
  Monitore, die keinen eigenen Override haben.
- **Monitor-Override** (`wallpaper set X --monitor DP-1`): gilt nur für diesen
  Monitor und bleibt auch beim Wechsel des Defaults erhalten.
- **`--all`**: setzt den Default und löscht alle Overrides, sodass überall
  dasselbe Bild erscheint.

---

## Privates Wallpaper-Repository (Urheberrecht)

Die Wallpaper liegen **nicht** im öffentlichen Dotfiles-Repo, sondern in:

```text
~/git/dotfiles/pictures/
```

Das Verzeichnis ist in `.gitignore` eingetragen und wird nicht mit dem
Dotfiles-Repo veröffentlicht. Es ist ein eigenständiges privates Git-Repo –
bewusst **kein Git-Submodul** im Dotfiles-Repo. Dadurch steht die private URL
nicht in `.gitmodules` und die Bilder sind nicht Teil des öffentlichen Repos.

### Einmalig einrichten

```bash
~/git/dotfiles/scripts/install-wallpapers.sh <git-url>
```

Alternativ manuell:

```bash
cd ~/git/dotfiles
git clone <git-url> pictures
```

### Aktualisieren

```bash
~/git/dotfiles/scripts/install-wallpapers.sh --update
# oder:
git -C ~/git/dotfiles/pictures pull --ff-only
```

Das Dotfiles-Repo bleibt sauber: `pictures/` taucht nicht in `git status` auf.

> **Achtung:** `pictures/` ist absichtlich ignoriert. Ein `git clean -fdx` im
> Dotfiles-Repo würde das private Wallpaper-Repo löschen. Vorher committen und
> pushen.

---

## Eigene Wallpapers hinzufügen

### Standardordner

Lege die Bilder hier ab:

```text
~/git/dotfiles/pictures/
```

Unterordner sind erlaubt und werden rekursiv durchsucht, z. B.:

```text
~/git/dotfiles/pictures/Natur/wald.jpg
~/git/dotfiles/pictures/Abstrakt/blau.png
```

Danach reicht ein neuer Aufruf von `wallpaper` oder `wallpaper list` – die
Bilder erscheinen **sofort**, ohne Hyprland- oder hyprpaper-Neustart:

```bash
wallpaper          # TUI öffnen und neues Bild auswählen
wallpaper list     # oder nur die Liste anzeigen
```

### Über das Tool übernehmen

```bash
# Bild in die private Bibliothek kopieren
wallpaper add ~/Downloads/mein-bild.jpg

# Direkt als Default setzen
wallpaper add ~/Downloads/mein-bild.jpg --set

# Verschieben statt kopieren
wallpaper add ~/Downloads/mein-bild.jpg --move
```

`wallpaper add` legt das Bild im ersten beschreibbaren Ordner aus
`WALLPAPER_DIRS` ab – standardmäßig in `~/git/dotfiles/pictures`. Existiert der
Dateiname schon, wird automatisch ein Suffix wie `-1` angehängt. Danach kannst
du die neuen Bilder im privaten Repo committen:

```bash
git -C ~/git/dotfiles/pictures add .
git -C ~/git/dotfiles/pictures commit -m "Add wallpapers"
git -C ~/git/dotfiles/pictures push
```

### Weitere Ordner verwenden

Weitere Quellen (Ordner oder Dateimuster) stehen in
`~/.config/wallpaper/wallpaper.conf`:

```bash
WALLPAPER_DIRS=(
    "${DOTFILES_ROOT:-$HOME/git/dotfiles}/pictures"
    "/pfad/zu/meinen/wallpapers"
    "/usr/share/hypr/wall*.png"
)
WALLPAPER_FIT="cover"   # cover | contain | tile | fill
```

- `DOTFILES_ROOT` wird vom Wallpaper-Skript automatisch auf das
  Dotfiles-Repo gesetzt; der Fallback funktioniert auch beim manuellen Sourcen.
- Ordner werden rekursiv gelesen; Dateimuster wie `/usr/share/hypr/wall*.png`
  sind ebenfalls erlaubt.
- `~` wird unterstützt, besser ist aber `$HOME` (wird beim Einlesen expandiert).
- Nach Änderungen genügt `wallpaper list` bzw. `wallpaper` – kein Neustart nötig.
- Mit `wallpaper dirs` prüfst du, welche Quellen aktuell gefunden werden.

### Unterstützte Formate

PNG, JPG/JPEG, WebP, GIF, BMP, AVIF, JXL und TIF/TIFF.

### Dateinamen & Auswahl

- Eindeutige Namen sind am bequemsten: `wallpaper set wald.jpg`
- Bei gleichen Dateinamen in verschiedenen Ordnern den relativen Pfad angeben:
  `wallpaper set Natur/wald.jpg`
- Absolute Pfade funktionieren ebenfalls:
  `wallpaper set /pfad/zu/bild.png`
- In der TUI einfach lostippen, um die Liste zu filtern; `Enter` wählt aus.

---

## Dateien

| Pfad | Zweck |
| :--- | :--- |
| `~/git/dotfiles/pictures` | Privates Wallpaper-Repo (gitignoriert, nicht im öffentlichen Dotfiles-Repo) |
| `~/git/dotfiles/scripts/install-wallpapers.sh` | Klont/aktualisiert das private Wallpaper-Repo |
| `~/.config/wallpaper/wallpaper.conf` | Wallpaper-Ordner, Fit-Modus, Benachrichtigungen |
| `~/.config/wallpaper/wallpaper.sh` | CLI- und TUI-Programm (auch als `wallpaper` in `~/.local/bin`) |
| `~/.local/state/wallpaper/state` | Gespeicherter Default und Monitor-Overrides |
| `~/.config/hypr/hyprpaper.conf` | hyprpaper-Grundeinstellungen (`splash = false`) |

Der Zustand wird bewusst unter `~/.local/state` gespeichert, damit
`wallpaper set ...` keine Änderungen im Dotfiles-Repository erzeugt.

---

## Tastenkürzel & CLI

- **`SUPER + SHIFT + W`** öffnet die Wallpaper-TUI.
- Alternativ per CLI: `wallpaper` (TUI) bzw. `wallpaper list`, `wallpaper set …`.
- In der Waybar gibt es bewusst kein Wallpaper-Symbol; die Steuerung erfolgt
  nur über Tastenkürzel oder CLI.

---

## Voraussetzungen

```bash
sudo pacman -S hyprpaper jq fuzzel
```

`hyprpaper` wird von `wallpaper apply` automatisch gestartet, falls es noch
nicht läuft. `scripts/install.sh` installiert das Paket mit.
