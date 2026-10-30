# Arch Dotfiles

Einzeln installierbare Pacman-Pakete für Hyprland, Waybar, Terminals, Editoren
und Shell. Quellen und Paketrezepte liegen in eigenen GitHub-Repositories.
Ein signiertes GitHub-Release stellt das Pacman-Repository bereit:
Installation und Updates erfolgen mit `pacman -Syu`, nicht über Git-Subtrees.

Schnellstart: `curl -fsSL https://raw.githubusercontent.com/MichaelWeissDEV/dotfiles/main/install.sh | bash`.

Start: [Installation](installation.md) ·
[Paketierung, GitHub-Repository und Migration](arch-package.md).

```{toctree}
:maxdepth: 2
:caption: System Guides

installation
arch-package
hyprland
waybar
terminals
shell
subtrees
```

Die Anwendungsanleitungen beschreiben weiterhin die Konfiguration unter
`~/.config/<modul>`. Quellpfade aus der früheren Struktur liegen jetzt unter
den jeweils eigenständigen `<modul>-config`-Repositories. Frühere subtree-spezifische
Installationshinweise sind durch die Paket-Anleitung ersetzt.
