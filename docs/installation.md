# Installation

Die unterstützte Arch-Installation verwendet einzelne Pacman-Pakete statt
Git-Subtrees und eines monolithischen Dotfiles-Installers.

Einmaliger Installer:

```bash
curl -fsSL https://raw.githubusercontent.com/MichaelWeissDEV/dotfiles/main/install.sh | bash
```

Alternativ manuell:

1. Das signierte GitHub-Repository nach der [Paket-Anleitung](arch-package.md)
   einrichten und den Signierschlüssel unabhängig verifizieren.
2. Gewünschte Konfigurationspakete auswählen; Abhängigkeiten installiert Pacman.
3. Als normaler Benutzer aktivieren, damit bestehende Einstellungen gesichert
   und editierbare Konfigurationskopien angelegt werden.

```bash
sudo pacman -Syu --needed arch-dotfiles-nvim arch-dotfiles-tmux
arch-dotfiles-config activate nvim tmux

# Oder die komplette Desktop-/Terminal-Umgebung:
sudo pacman -Syu --needed arch-dotfiles
arch-dotfiles-config activate
```

Updates: `adot update` oder `sudo pacman -Syu` gefolgt von
`arch-dotfiles-config update`. Optional synchronisiert der User-Timer
`arch-dotfiles-sync.timer` die Defaults automatisch. Eigene Änderungen werden
nicht überschrieben; neue Defaults erscheinen als `.pacnew`.

Für die Pacman-Registry gilt: ein Push löst auf GitHub selbst **keinen**
Registry-Build aus (kein Cross-Repository-Trigger, GitHub drosselt Cronpläne).
Der opt-in Timer `arch-dotfiles-registry-kick.timer` (enthalten in
`arch-dotfiles-core`) überbrückt das: er vergleicht die veröffentlichte
`sources.json` mit `main` aller Komponenten und des hubs und startet den
zentralen `Arch packages`-Workflow genau dann, wenn ein Paket hinter
`main` zurückliegt. Voraussetzung ist ein angemeldeter `gh` (`gh auth login`);
ohne ihn übernimmt der halbstündige Fallback-Cron des Workflows. Nichts wird
hier gebaut oder signiert — der Dispatch ist nur eine Anfrage an die bestehenden
Sicherheits- und Veröffentlichungsschritte.

Die Paket-Anleitung erklärt auch lokale Builds, die Umstellung vom bisherigen
Monolithen, einzelne Deinstallationen und Backups. Dienste und Login-Shell werden
nicht automatisch geändert. Auf anderen Plattformen können die einzelnen
Quellen der einzelnen `<modul>-config`-Repositories manuell verwendet werden; die Pacman-Registry
ist ausdrücklich für Arch Linux gedacht.
