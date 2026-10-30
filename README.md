# Arch Dotfiles

**Einmal installieren. In einzelnen Repositories entwickeln. Mit `pacman -Syu` aktualisieren.**

Dieses Repository enthält Installer, Paketverwaltung und die signierte
Pacman-Registry. Die 16 Konfigurationen liegen in **eigenen GitHub-Repositories**,
nicht mehr als Subtrees oder Konfigurationskopien in diesem Repository.

## Installation

Auf Arch Linux als normaler Benutzer mit `sudo`:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelWeissDEV/dotfiles/main/install.sh | bash
```

Oder nur ausgewählte Konfigurationen installieren:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelWeissDEV/dotfiles/main/install.sh | bash -s -- nvim tmux
```

Der Installer prüft den fest hinterlegten Signierschlüssel, richtet das
Pacman-Repository ein, installiert Pakete samt Abhängigkeiten, sichert bestehende
Einstellungen und aktiviert die Benutzerkonfigurationen. Ein User-Timer übernimmt
künftig aktualisierte Defaults. Eigene Änderungen werden nicht überschrieben;
neue Defaults erscheinen als `.pacnew`. Dienste des Systems und Login-Shell werden
nicht automatisch umgestellt. Wie bei jedem Remote-Installer vertraust du beim
Ausführen dem Quellcode dieses GitHub-Repositories; du kannst `install.sh` vorher
herunterladen und prüfen.

Signierschlüssel-Fingerprint:

```text
5635 E5E9 3F5B A18D 8868 AAB5 A8DD 6392 7F15 1C4D
```

## Updates

```bash
sudo pacman -Syu
```

Nach erfolgreichem Registry-Build sind neue Konfigurationspakete normale
Pacman-Updates. Der installierte User-Timer synchronisiert die Defaults innerhalb
von etwa zwei Minuten. Sofortige Synchronisation: `adot sync`.
Die betroffene Anwendung gegebenenfalls neu laden/starten.

## Entwicklung: unabhängige Repositories

```bash
mkdir -p ~/git/config
git clone git@github.com:MichaelWeissDEV/dotfiles.git ~/git/config/dotfiles
bash ~/git/config/dotfiles/scripts/clone-repos.sh
```

Danach liegen alle Repositories nebeneinander:

```text
~/git/config/
  dotfiles/          # Installer, Registry, gemeinsame Verwaltung
  nvim-config/       # eigene Git-Historie, main, Quellen und PKGBUILD
  tmux-config/
  hypr-config/
  zsh-config/
  ...
```

Die vollständige Zuordnung steht in [`repositories.json`](repositories.json).
Vorhandene Arbeitskopien werden nicht überschrieben. Explizite Updates sauberer
`main`-Checkouts: `bash scripts/clone-repos.sh --update`.

Beispiel:

```bash
cd ~/git/config/nvim-config
# Konfiguration bearbeiten
git add lua/config
git commit -m "Adjust editor configuration"
git push origin main
```

Die Registry prüft die `main`-Stände **alle fünf Minuten**. GitHub kann geplante
Läufe verzögern; hinzu kommt die Build-Zeit. Nach dem erfolgreichen Build erhält
das nächste `pacman -Syu` die neue Version. Es ist kein manuelles Versionsbumpen
für normale Konfigurationsänderungen erforderlich. Sofortiger Build-Start für
Maintainer:

```bash
gh workflow run packages.yml -R MichaelWeissDEV/dotfiles
```

## Paketstruktur

- 16 Konfigurationspakete, jeweils aus einem eigenen Repository.
- `arch-dotfiles-core`: `adot`, Aktivierung, Backups und User-Synchronisation.
- `arch-dotfiles-oh-my-zsh`: separat gepinnter Oh-My-Zsh-Runtime.
- `arch-dotfiles`: optionales Metapaket für die komplette Umgebung.

Jede Konfiguration pflegt ihre Abhängigkeiten und ihr Rezept selbst in
`packaging/arch/PKGBUILD`. Hier bleiben nur die drei gemeinsamen Paketordner
unter `packages/`. Alle Pakete und Repository-Daten werden signiert als Assets
des GitHub-Releases [`repo`](https://github.com/MichaelWeissDEV/dotfiles/releases/tag/repo)
veröffentlicht. `sources.json` dort dokumentiert die tatsächlich gebauten Commits.

**[Builds, Sicherheit, Migration und Deinstallation](packaging/arch/README.md)** ·
**[Anwendungsdokumentation](https://arch-dotfiles.readthedocs.io/en/latest/)**
