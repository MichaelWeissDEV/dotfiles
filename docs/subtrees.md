# Migration: Git-Subtrees zu Paketen

Git-Subtrees werden nicht mehr aktualisiert oder verteilt. Die vollständigen
Quellen liegen getrennt in eigenständigen GitHub-Repositories laut `repositories.json` und werden
als einzeln versionierte Pacman-Pakete veröffentlicht.

Die vorhandene Git-Historie und Remotes bleiben erhalten. Es ist kein
History-Rewrite notwendig. Installierte Systeme benötigen keinen Git-Checkout;
sie beziehen Pakete und Updates aus dem signierten GitHub-Pacman-Repository.

```bash
sudo pacman -Syu --needed arch-dotfiles-nvim arch-dotfiles-tmux
arch-dotfiles-config activate nvim tmux
sudo pacman -Syu
arch-dotfiles-config update
```

Siehe [Installation, Veröffentlichung und sichere Migration](arch-package.md).
