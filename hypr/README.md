# Hyprland Konfiguration – Catppuccin Mocha (Pastel Theme)

Diese Konfiguration ist auf **maximale Reaktionsgeschwindigkeit (Instant Reactions)**, **maximale Bildschirmfläche** und das offizielle **Catppuccin Mocha Pastell-Farbschema** ausgelegt – ohne unnötige Zusatzprogramme.

---

## Start aus der TTY
Das System startet bewusst **nicht** automatisch in eine grafische Oberfläche, sondern in die normale **TTY**.
Nach dem Login startest du Hyprland manuell mit:
```bash
start-hyprland
```
*(Alternativ funktioniert auch direkt `Hyprland`.)*

---

## App-Launcher & Power-Menü in der Leiste (Waybar)
- **App-Launcher (Links oben `󰀻` oder per Tastatur):**
  - Ein Klick auf das App-Symbol `󰀻` **links oben in der Waybar** (oder `SUPER + Leertaste`, `ALT + Leertaste`, `SUPER + D`, `SUPER + R`, `SUPER + A`) öffnet den sauber im matten Theme gestylten **App-Launcher (`fuzzel`)**.
  - **Programme starten:** Einfach lostippen, mit Pfeiltasten auswählen und `Enter` drücken (oder mit der Maus anklicken).
  - **Beliebige Befehle direkt ausführen:** Befehl eintippen und `SHIFT + Enter` drücken.
  - **WLAN / Netzwerk:** Direkt über den Eintrag *„WLAN & Netzwerk (nmtui)“* im App-Launcher erreichbar.
- **Power-Menü (Rechts oben `󰐥`):**
  - **Linksklick auf `󰐥`:** Öffnet direkt ein kleines Dropdown-Menü unter der Leiste:
    - `󰐥  Herunterfahren` (`systemctl poweroff`)
    - `󰜉  Neu starten` (`systemctl reboot`)
    - `󰤄  Standby` (`systemctl suspend`)
    - `󰌾  Bildschirm sperren` (`hyprlock`)
    - `󰍃  Abmelden (TTY)` (`hyprctl dispatch exit`)
  - **Rechtsklick auf `󰐥`** *(oder Tastenkombination `SUPER + Escape`)*: Öffnet dasselbe Menü rechts oben über `fuzzel` (auch komplett per Pfeiltasten + Enter bedienbar).

---

## Tastenkombinationen (Keybindings)

Als Haupt-Modifikatortaste (`SUPER`) dient die **Windows-/Super-Taste**.

### Programme & System
| Tastenkombination | Aktion |
| :--- | :--- |
| `SUPER + Leertaste` *(oder `ALT + Leertaste`, `SUPER + D`, `SUPER + R`, `SUPER + A`)* | App-Launcher öffnen / schließen (`fuzzel`) |
| `SUPER + Enter` *(oder `SUPER + Q`)* | Terminal öffnen (`kitty` mit `zsh` + Oh My Zsh, leicht transparent `0.90`) |
| `SUPER + SHIFT + Enter` | Terminal direkt in durchgehender **Tmux-Session** öffnen (`tmux new-session -A -s main`) |
| `SUPER + E` | **GUI-Dateimanager** öffnen (`pcmanfm`, im Catppuccin Mocha GTK-Theme) |
| `SUPER + Y` | **TUI-Dateimanager** öffnen (`yazi`, im offiziellen Catppuccin Mocha Flavor) |
| `SUPER + B` | Browser öffnen (`firefox`) |
| `SUPER + L` | Bildschirm sperren (`hyprlock`) |
| `SUPER + Escape` | Power-Menü rechts oben öffnen (Herunterfahren, Neustart, Standby, Sperren, Abmelden) |
| `SUPER + SHIFT + B` | Waybar neu laden / neu starten |
| `SUPER + SHIFT + E` *(oder `SUPER + M`)* | Hyprland direkt beenden (zurück zur TTY) |

### Bildschirme / Workspaces (Unbegrenzt / Infinity)
Die Workspaces sind **nicht auf eine feste Anzahl begrenzt**. In der Waybar links oben werden nur tatsächlich vorhandene/aktive Bildschirme angezeigt.
| Tastenkombination | Aktion |
| :--- | :--- |
| `STRG + ALT + ← / →` | Einen Bildschirm/Workspace nach **links** (`r-1`) bzw. **rechts** (`r+1`) wechseln |
| `STRG + ALT + 1..9, 0` | Zu Bildschirm/Workspace `<num>` wechseln, **sofern dieser vorhanden ist** (prüft aktive Workspaces sowie angeschlossene Monitore, ohne leere Zwischen-Workspaces zu erzeugen) |
| `STRG + ALT + SHIFT + ← / →` | Aktives Fenster einen Bildschirm/Workspace nach links (`r-1`) / rechts (`r+1`) mitnehmen |
| `SUPER + 1..9, 0` | Direkt zu Workspace 1 bis 10 wechseln (oder neu anlegen, falls noch nicht vorhanden) |
| `SUPER + SHIFT + 1..9, 0` | Aktives Fenster auf Workspace 1 bis 10 verschieben |
| `SUPER + .` *(Punkt)* oder `SUPER + Bild↓` | Einen Workspace weiter (`r+1`, unbegrenzt nach rechts/oben) |
| `SUPER + ,` *(Komma)* oder `SUPER + Bild↑` | Einen Workspace zurück (`r-1`) |
| `SUPER + N` | Zum nächsten komplett freien/leeren Workspace springen (`empty`) |
| `SUPER + SHIFT + .` / `SUPER + SHIFT + ,` | Fenster einen Workspace weiter (`r+1`) / zurück (`r-1`) verschieben |
| `SUPER + SHIFT + N` | Fenster auf den nächsten komplett freien Workspace verschieben |
| `SUPER + Mausrad hoch/runter` | Durch Workspaces blättern (`r-1` / `r+1`) |
| `3-Finger-Wischen (Touchpad)` | Horizontal zwischen Workspaces wechseln |
| `SUPER + S` | Scratchpad (unsichtbare Ablage) ein-/ausblenden |
| `SUPER + SHIFT + S` | Aktives Fenster ins Scratchpad verschieben |

### Fenster-Steuerung
| Tastenkombination | Aktion |
| :--- | :--- |
| `SUPER + C` *(oder `SUPER + W`)* | Aktives Fenster schließen |
| `SUPER + F` | Echtes Vollbild umschalten (Fullscreen) |
| `SUPER + SHIFT + F` | Maximiert umschalten (Waybar bleibt sichtbar) |
| `SUPER + V` | Schwebendes Fenster umschalten (Floating) |
| `SUPER + T` | Split-Richtung umschalten (Horizontal / Vertikal) |
| `SUPER + P` | Pseudo-Tiling umschalten |
| `SUPER + Pfeiltasten (←/→/↑/↓)` | Fokus zwischen Fenstern wechseln |
| `SUPER + SHIFT + Pfeiltasten (←/→/↑/↓)` | Aktives Fenster in Richtung verschieben |
| `SUPER + CTRL + Pfeiltasten (←/→/↑/↓)` | Fenstergröße schrittweise anpassen |
| `SUPER + Linke Maustaste ziehen` | Fenster mit der Maus verschieben |
| `SUPER + Rechte Maustaste ziehen` | Fenstergröße mit der Maus ändern *(oder direkt am Fensterrand ziehen)* |

### Screenshots & Medien
| Tastenkombination | Aktion |
| :--- | :--- |
| `Druck (Print)` | Ganzen Bildschirm aufnehmen (in Zwischenablage + `~/Downloads/`) |
| `SUPER + SHIFT + P` | Bereich auswählen und aufnehmen (in Zwischenablage + `~/Downloads/`) |
| `Lautstärke + / - / Mute` | Lautstärke in 5%-Schritten regeln / Stummschalten (`wpctl`) |
| `Helligkeit + / -` | Bildschirmhelligkeit in 5%-Schritten regeln (`brightnessctl`) |

---

## Zsh (Oh My Zsh) & Tmux (Catppuccin Mocha)

### Zsh & Oh My Zsh
- **Standard-Shell:** `zsh` ist als System-Shell gesetzt und startet automatisch in jedem neuen `kitty`- und `foot`-Fenster.
- **Konfiguration:** `~/.zshrc` mit eigenem **Catppuccin Mocha Pastell-Theme** (`~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme`).
- **Aktive Plugins:**
  - `git` (Git-Kürzel und Branch-/Status-Anzeige im Prompt)
  - `sudo` (2× `Escape` drücken setzt automatisch `sudo` vor den aktuellen/letzten Befehl)
  - `zsh-autosuggestions` (Befehlsvorschläge beim Tippen in dezentem Grau – mit Pfeiltaste `→` annehmen)
  - `zsh-syntax-highlighting` (Befehle werden schon beim Tippen in Catppuccin-Pastellfarben hervorgehoben)
- **Schnell-Aliases für Tmux im Terminal:**
  - `tm` → Startet oder verbindet sich mit der Haupt-Session `main`
  - `tn <name>` → Neue Session mit Namen erstellen
  - `ta <name>` → Mit bestehender Session verbinden
  - `tl` → Alle laufenden Tmux-Sessions auflisten

### Tmux Tastenkombinationen (`~/.config/tmux/tmux.conf`)
Als **Prefix** funktionieren sowohl klassisch **`STRG + B`** als auch **`STRG + A`**. Die Maus ist komplett aktiv (Klicken auf Panes/Tabs, Ränder ziehen, Scrollen).
| Tastenkombination | Aktion in Tmux |
| :--- | :--- |
| `Prefix` + `v` *(oder `|`)* | Aktuelles Fenster **nebeneinander** teilen (im selben Ordner) |
| `Prefix` + `s` *(oder `-`)* | Aktuelles Fenster **untereinander** teilen (im selben Ordner) |
| `ALT + Pfeiltasten (←/→/↑/↓)` | **Direkt** (ohne Prefix!) zwischen geteilten Panes wechseln |
| `ALT + 1..9` | **Direkt** (ohne Prefix!) zu Tmux-Tab `1..9` wechseln |
| `Prefix` + `c` | Neuen Tmux-Tab (Window) im aktuellen Ordner öffnen |
| `Prefix` + `z` | Aktuelles Pane auf Vollbild zoomen / zurücksetzen |
| `Prefix` + `d` | Von Tmux-Session trennen (läuft im Hintergrund weiter; wieder öffnen mit `tm` oder `SUPER + SHIFT + Enter`) |
| `Prefix` + `r` | Tmux-Konfiguration live neu laden |

---

## Übersicht der Konfigurationsdateien

- **Hyprland:** `~/.config/hypr/hyprland.lua`
- **Power-Menü & Sudo-Askpass:** `~/.config/hypr/powermenu.sh` & `~/.config/hypr/askpass.sh`
- **Sperrbildschirm:** `~/.config/hypr/hyprlock.conf`
- **Waybar (Leiste oben):** `~/.config/waybar/config.jsonc`, `~/.config/waybar/style.css` & `~/.config/waybar/power_menu.xml`
- **Zsh & Oh My Zsh:** `~/.zshrc` & `~/.oh-my-zsh/custom/themes/catppuccin.zsh-theme` *(inkl. `y`-Befehl für `yazi`)*
- **Tmux:** `~/.config/tmux/tmux.conf` *(verlinkt nach `~/.tmux.conf`)*
- **Dateimanager (TUI – Yazi):** `~/.config/yazi/yazi.toml` & `~/.config/yazi/theme.toml` *(Catppuccin Mocha Flavor)*
- **Dateimanager (GUI – PCManFM) & GTK-Theme:** `~/.config/gtk-3.0/gtk.css`, `~/.config/gtk-3.0/settings.ini`, `~/.config/gtk-4.0/gtk.css` & `~/.config/libfm/libfm.conf`
- **Terminal (Kitty):** `~/.config/kitty/kitty.conf` *(leicht transparent `0.90`)*
- **Terminal (Foot):** `~/.config/foot/foot.ini` *(leicht transparent `0.90`)*
- **Editor (Neovim):** `~/.config/nvim/init.lua`
- **App-Launcher (Fuzzel):** `~/.config/fuzzel/fuzzel.ini`

## Farbpalette (Official Catppuccin Mocha – Pastel Theme)
- **Base (Terminal- & Leisten-Hintergrund):** `#1e1e2e` *(100% deckend)*
- **Mantle / Crust (Dunkle Module):** `#181825` / `#11111b`
- **Surface0 / Surface1 (Auswahl & Ränder):** `#313244` / `#45475a`
- **Text / Subtext (Vordergrund):** `#cdd6f4` / `#a6adc8`
- **Pastel Blue (Hauptakzent / Aktiver Fokus):** `#89b4fa`
- **Pastel Teal & Sapphire (Sekundärakzente):** `#94e2d5` / `#74c7ec`
- **Pastel Green (Prompt & Akku lädt):** `#a6e3a1`
- **Pastel Lavender & Mauve (Prompt-Badges & Keywords):** `#b4befe` / `#cba6f7`
- **Pastel Red & Peach (Warnung/Kritisch):** `#f38ba8` / `#fab387`
