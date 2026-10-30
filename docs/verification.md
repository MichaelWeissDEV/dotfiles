# Installation prüfen und Fehler vermeiden

## Auf einem installierten Rechner

```bash
pacman -Q | grep '^arch-dotfiles'
pacman -Qkk $(pacman -Qq | grep '^arch-dotfiles')
arch-dotfiles-config status
systemctl --user status arch-dotfiles-sync.timer
systemctl --user status arch-dotfiles-sync.service
```

Bei einer vollständigen Installation sind 19 Pakete vorhanden. Eine absichtlich
selektive Installation benötigt weniger. `-Qkk` prüft Paketdateien unter `/usr`,
nicht deine editierbaren Kopien. Ein erfolgreicher oneshot-Sync-Service darf als
`inactive (dead)` erscheinen; entscheidend sind Exit-Code 0 und der aktive Timer.

```bash
adot sync
find "${XDG_DATA_HOME:-$HOME/.local/share}/arch-dotfiles/config" -name '*.pacnew*'
journalctl --user -u arch-dotfiles-sync.service -n 30 --no-pager
```

Eigene Änderungen werden nicht automatisch zusammengeführt. `.pacnew`-Dateien
prüfen und erst dann die betroffene Anwendung neu laden. Niemals `/usr`-Defaults
editieren, Aktivierung als root ausführen oder mit `--overwrite '*'` Konflikte
verdecken. Ein vorhandener gleichnamiger manueller Pacman-Repository-Abschnitt
muss vor einer erneuten Installer-Nutzung überprüft werden.

## Automatische Sicherheitsprüfungen

- Jedes Komponenten-Repository prüft auf Push und Pull Request sein Paket-Rezept,
  Shell-/Python-/TOML-/JSONC-/INI-/XML-Syntax, Einstiegspunkte, Modulinventar und das isolierte
  `/usr`-Payload. Git-Metadaten und aus dem Paket ausbrechende Links sind verboten.
- Repositories mit `.readthedocs.yaml` bauen ihre Dokumentation mit derselben
  Python-Version und `sphinx-build -W --keep-going`, bevor Änderungen als grün gelten.
- Vor einem Registry-Build laufen zentrale Unit- und Dokumentationstests.
- Vor **jeder Veröffentlichung geänderter Pakete** wird mit einem nur für den Test
  erzeugten Schlüssel ein Repository gebaut. Pacman muss fehlende Signaturen
  ablehnen und alle 19 Pakete in einer temporären Root installieren können.
- Zuvor wird die vollständige Abhängigkeitsauflösung offline gegen die vorhandenen
  offiziellen Arch-Sync-Datenbanken geprüft. Programme werden für diesen Test
  nicht auf dem Entwicklerrechner nachinstalliert.
- In temporären Homes werden Aktivierung, Editor-/Shell-/tmux-Start,
  konfliktfreie Updates, `.pacnew` und Wiederherstellung der Backups getestet.

```bash
python3 -B -m unittest discover -s packaging/arch/tests -v
python3 packaging/arch/check-component.py
bash packaging/arch/build.sh all
python3 packaging/arch/check-artifacts.py
python3 packaging/arch/smoke-install.py
```

Der Smoke-Test läuft **ohne echte Root-Rechte** mit `fakeroot`, eigenen Pacman-
Datenbanken und eigenen Homes. Er benötigt die Build-Werkzeuge, GnuPG sowie
aktuelle vorhandene Arch-Sync-Datenbanken. Installations-Scriptlets sind in der
temporären Root deaktiviert; produktive Scriptlets schreiben ausschließlich
Hinweise und bearbeiten keine Home-Verzeichnisse.

Diese Tests ersetzen keine visuelle Prüfung in einer echten Wayland-Sitzung.
Monitore, Grafiktreiber, Audio, Bluetooth, Portale und persönliche Dienste sind
rechnerabhängig. CI startet oder beendet keine laufende grafische Benutzersitzung.

## GitHub CLI für Maintainer

Die GitHub CLI muss dauerhaft auf `PATH` liegen, nicht nur in einem temporären
Build-Ordner. Auf Arch kann sie regulär mit `sudo pacman -Syu --needed github-cli`
installiert werden. Alternativ eignet sich das offizielle, gegen die
Release-Prüfsumme geprüfte Binary unter `~/.local/bin/gh`; diese manuelle
Installation wird nicht von Pacman aktualisiert.

```bash
command -v gh
gh --version
gh auth status
gh run list -R MichaelWeissDEV/dotfiles --workflow packages.yml
```

Keine Tokens oder privaten Signierschlüssel in Issue-/CI-Logs oder Git committen.
