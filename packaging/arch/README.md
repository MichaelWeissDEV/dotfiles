# Arch Dotfiles: Installation, Entwicklung und Registry

## Schnellinstallation

Als normaler Arch-Benutzer, nicht als root:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelWeissDEV/dotfiles/main/install.sh | bash
# Oder nur ausgewählte Pakete:
curl -fsSL https://raw.githubusercontent.com/MichaelWeissDEV/dotfiles/main/install.sh | bash -s -- nvim tmux
```

Alternativ das Script herunterladen, prüfen und `bash install.sh` ausführen.
Optionen: `--help`, `--dry-run`, `--yes`, `--no-activate`, `--no-sync`.
Vorhandene abweichende Registry-Einstellungen werden nicht überschrieben.

Der Installer lädt den öffentlichen Schlüssel und vergleicht den Fingerprint
mit dem fest hinterlegten Wert, bevor er ihn in Pacman importiert und lokal
signiert. Er aktiviert Paket- **und** Datenbanksignaturprüfungen:

```ini
[arch-dotfiles]
SigLevel = Required DatabaseRequired
Server = https://github.com/MichaelWeissDEV/dotfiles/releases/download/repo
```

Die Datei liegt unter `/etc/pacman.d/arch-dotfiles.conf`; in `/etc/pacman.conf`
wird ein idempotenter Include ergänzt. Ein bereits manuell eingetragener
gleichnamiger Abschnitt muss vorher überprüft und durch diesen Include ersetzt
werden. Der öffentlich bekannte Fingerprint sollte zusätzlich unabhängig geprüft
werden. Ein kompromittierter Remote-Installer wäre selbst mit Signaturprüfung
gefährlich; führe nur Quellcode aus, dem du vertraust.

## Was wird installiert?

16 unabhängig gepflegte Konfigurationen, ein gemeinsames Verwaltungspaket, ein
Oh-My-Zsh-Runtime-Paket und ein optionales Gesamt-Metapaket. Konfigurationen liegen
in eigenen Repositories laut `repositories.json`; deren `packaging/arch/PKGBUILD`
bestimmt Abhängigkeiten. Beispielsweise installiert `arch-dotfiles-nvim` nicht
den gesamten Hyprland-Desktop. Desktop-Konfigurationen deklarieren dagegen die
benötigten anderen Desktop-Komponenten ausdrücklich als Abhängigkeiten.

Pacman besitzt Defaults unter `/usr/share/arch-dotfiles`, Programme unter
`/usr/bin` und User-Units unter `/usr/lib/systemd/user`. Weder Paket-Scriptlets
noch Root-Hooks bearbeiten Home-Verzeichnisse.

## Aktivierung und Updates

`arch-dotfiles-config activate [modul ...]` sichert vorhandene Einstellungen und
erstellt benutzereigene Kopien in
`${XDG_DATA_HOME:-~/.local/share}/arch-dotfiles/config`. Diese werden nach
`~/.config/<modul>` verlinkt; Zsh, tmux und Vim erhalten ihre Home-Einstiege.
Backups und Aktivierungsjournal liegen in
`${XDG_STATE_HOME:-~/.local/state}/arch-dotfiles`. Lokale Monitorregeln und tmux
`local*.conf` werden übernommen. `XDG_CONFIG_HOME` muss `~/.config` sein; eigene
absolute Daten-/State-Pfade werden unterstützt.

Der Installer aktiviert `arch-dotfiles-sync.timer` für den aufrufenden Benutzer:

```bash
sudo pacman -Syu                    # neue Konfigurationspakete installieren
adot sync                          # optional sofort statt Timer abwarten
```

Der Timer läuft etwa alle zwei Minuten und synchronisiert nur aktive Module.
Unveränderte Dateien werden ersetzt; eigene Änderungen bleiben mit neuen
`.pacnew`-Defaults daneben. Nach dem Merge die jeweilige Anwendung neu laden.
Andere Benutzer müssen jeweils selbst aktivieren und ihren Timer einschalten.
Kein automatischer Neustart der grafischen Sitzung. Ohne aktivierten Timer ist
`arch-dotfiles-config update` ein ausdrücklicher separater Schritt.

## Entwickeln und veröffentlichen

```bash
bash scripts/clone-repos.sh
cd ../nvim-config
# Änderungen bearbeiten, committen und nach main pushen
git push origin main
```

Der zentrale Workflow `packages.yml` klont die `main`-Stände aller 16 Repositories
und prüft alle fünf Minuten sowie bei zentralen `main`-Pushes oder manuellen
Starts auf Änderungen. Geplante GitHub-Läufe können verzögert werden. Nach einem
erfolgreichen Build und Publish enthält das nächste `pacman -Syu` die neuen
Konfigurationen. Ein Push alleine bedeutet noch nicht, dass ein Paket verfügbar
ist. Der Status ist im zentralen Actions-Workflow sichtbar.

```bash
gh workflow run packages.yml -R MichaelWeissDEV/dotfiles
```

Die Pakete erhalten automatisch eine Version der Form
`0.3.0.r<Anzahl-Quellcommits>.g<Commit>-<Anzahl-Hubcommits>`.
Konfigurationsänderungen benötigen deshalb keinen manuellen Versionsbump. Ein
Hub-Commit erhöht zusätzlich die Paketierungsrevision, damit zentrale
Exportänderungen ebenfalls neue Pakete ergeben. `main` nicht force-pushen:
die Commitzahl dient als monoton steigende Versionskomponente. Bei absichtlichem
History-Rewrite muss die Basisversion im Rezept erhöht werden.

Unveränderte Quellen werden aus bereits veröffentlichten Artefakten
wiederverwendet. Der Publisher gleicht zwischenzeitlich veröffentlichte Pakete
ab und verwendet deren originale Bytes, damit Datenbankprüfsummen stimmen.
Vorhandene neuere Paketversionen werden nicht durch ältere Builds herabgestuft.
Alte Paketdateien bleiben für Clients mit gecachten Datenbanken verfügbar.
`sources.json` im Release dokumentiert die Quellcommits des Builds. Während des
kurzen Austauschs separater Datenbank-/Signaturdateien kann ein Download scheitern;
dann später `pacman -Syu` wiederholen, nicht die Signaturprüfung abschalten.

## Lokale Builds

```bash
sudo pacman -Syu --needed base-devel git python
bash scripts/clone-repos.sh
bash packaging/arch/build.sh arch-dotfiles-nvim
bash packaging/arch/build.sh all
python3 packaging/arch/check-artifacts.py
```

Als normaler Benutzer ausführen. Ergebnisse liegen in
`packaging/arch/build/<paket>/`. Neue Dateien im jeweiligen Quellrepository vor
dem Build mit `git add` aufnehmen: Exportiert werden nur Git-versionierte
Quellen. Git-Metadaten, CI-Dateien, Paketrezepte, private Wallpaper,
Monitor-Overrides und tmux-Overrides werden nicht ausgeliefert. Plugin-Lizenzen
bleiben erhalten. Oh My Zsh wird aus einem gepinnten Commit mit festem SHA-256
gebaut. Builds installieren nichts; Runtime-Abhängigkeiten löst Pacman bei
Installation auf. Lokal gebaute interne Abhängigkeiten gemeinsam mit `pacman -U`
installieren, wenn sie nicht bereits aus der Registry verfügbar sind.

`ARCH_DOTFILES_SOURCE_ROOT` überschreibt den Ordner mit den Komponenten-Repos;
standardmäßig werden die Nachbarverzeichnisse des zentralen Checkouts verwendet.
`scripts/clone-repos.sh --update` aktualisiert nur saubere `main`-Arbeitskopien
per Fast-Forward. Keine lokalen Änderungen werden überschrieben.

## Signierschlüssel und CI

Nur das zentrale Repository braucht die Environment `pacman-repository`:

- Secret `PACMAN_SIGNING_KEY`: armierter privater Paket-Signierschlüssel.
- Optionales Secret `PACMAN_SIGNING_PASSPHRASE`.
- Variable `PACMAN_SIGNING_FINGERPRINT`: vollständiger Fingerprint.

Komponenten-Repositories erhalten **keinen privaten Signierschlüssel und keinen
Cross-Repository-Push-Token**. Pull Requests veröffentlichen nicht. Der private
Schlüssel liegt lokal geschützt unter `~/.local/state/arch-dotfiles/signing` und
wurde nicht eingecheckt. Diesen Ordner separat sicher sichern; Verlust oder
Rotation erfordert eine geplante Pacman-Schlüsselumstellung.

GitHub Releases sind der Downloadserver, nicht GHCR/GitHub Packages. Die
Repository-Dateien sind öffentlich; private Quell-Repositories benötigen eine
gesonderte CI-Authentifizierung und sind mit diesem Setup nicht vorgesehen.

## Migration und Entfernung

Vom bisherigen lokalen monolithischen Paket zuerst sauber migrieren:

```bash
arch-dotfiles-config deactivate
sudo pacman -R arch-dotfiles
# Danach den neuen Installer starten.
```

Keine erzwungenen `--overwrite '*'`-Installationen. Backups und Benutzerkopien
bleiben erhalten. Vorherige Subtree-Arbeitskopien dieses Umbaus sind lokal unter
`../.dotfiles-migration-backup` gesichert, nicht in GitHub veröffentlicht.
Vorherige Historie bleibt im zentralen Git erhalten; Remotes werden nicht
umgeschrieben. Die Konfigurationsquellen werden dort künftig nicht mehr gepflegt.

Ein einzelnes Paket entfernen:

```bash
arch-dotfiles-config deactivate nvim
sudo pacman -Rns arch-dotfiles-nvim
```

Falls das Gesamt-Metapaket installiert ist, dieses zuerst mit `pacman -R
arch-dotfiles` entfernen, um einzelne Abhängigkeiten entfernen zu können.
Vollständige Entfernung:

```bash
systemctl --user disable --now arch-dotfiles-sync.timer
arch-dotfiles-config deactivate
sudo pacman -Rns arch-dotfiles
```

`-Rns` entfernt nur unbenötigte, als Abhängigkeit installierte Pakete. Eigene
Kopien, Backups, Bilder und vorher explizit installierte Anwendungen bleiben
erhalten. Veränderte Aktivierungslinks werden nicht überschrieben.

## Tests

```bash
python3 -B -m unittest discover -s packaging/arch/tests -v
```

Die Tests installieren nichts und verwenden temporäre Homes.
