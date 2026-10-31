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

## Registry frisch halten

Die Registry wird aus dem Hub-Repository heraus gebaut. Nach erfolgreicher
Komponentenprüfung fordert ein Push auf `main` den zentralen Build direkt an.
Zusätzlich vergleicht `arch-dotfiles-registry-kick` die veröffentlichte `sources.json`
(alle Komponenten-Commits plus hub) mit dem `main` jeder Quelle und startet
den zentralen `Arch packages`-Workflow genau dann, wenn ein Paket hinter `main`
zurückliegt. Der Dispatch ist nur eine Anfrage — gebaut, signiert und
veröffentlicht wird ausschließlich der geprüfte hub-Workflow.

```bash
arch-dotfiles-registry-kick          # vergleicht, dispatcht nur bei Drift
systemctl --user status arch-dotfiles-registry-kick.timer
journalctl --user -u arch-dotfiles-registry-kick.service -n 30 --no-pager
```

Ohne `gh` oder ohne `gh auth login` beendet sich das Skript mit Hinweis und
Exit 0 — die Verantwortung liegt dann beim halbstündigen Cron des
`Arch packages`-Workflows. Ein „GitHub not reachable“ ist eine Verzögerung und
wird beim nächsten Timer-Tick wiederholt, kein Fehler.

### Push bis Paket

1. `git push origin main` im Komponenten-Repository startet dessen Workflow
   `Package safety`. Pull Requests prüfen ebenfalls, veröffentlichen aber nicht.
2. Nur nach erfolgreicher Prüfung fordert der Workflow mit dem Actions-Secret
   `DOTFILES_DISPATCH_TOKEN` den Workflow `Arch packages` im Hub an. Das Secret
   muss Zugriff auf GitHub Actions im Hub haben; sein Wert gehört nie in Git.
   Ein fehlendes oder ungültiges Secret lässt den Dispatch-Job sichtbar scheitern.
3. Der Hub klont die Komponenten auf `main`, prüft und baut die Pakete, testet
   Installation und Updates isoliert und veröffentlicht signierte Pakete und
   Repository-Datenbanken. Ein Push auf den Hub startet denselben Workflow direkt.
4. `sudo pacman -Syu` installiert veröffentlichte Updates. `adot sync` gleicht
   anschließend die Benutzerkopie ab; der optionale Sync-Timer erledigt dies
   ebenfalls. Änderungen des Benutzers bleiben erhalten; abweichende neue
   Vorgaben landen als `.pacnew` daneben und müssen geprüft werden.

Der Dispatch fordert einen Build an, er garantiert weder einen erfolgreichen
Build noch einen festen Veröffentlichungszeitpunkt. GitHub Actions und die
Signierungsumgebung müssen verfügbar sein. Der Registry-Timer und der Cron
sind zusätzliche Wiederholungsmöglichkeiten, keine Paket-Updater.

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
