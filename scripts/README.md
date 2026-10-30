# Migrations-Einstiege

Die eigentlichen Programme liegen jetzt im Paket
`packages/arch-dotfiles-core/`. `scripts/adot`, `install.sh` und
`install-links.sh` delegieren an das installierte Paket. Es werden keine
Git-Subtrees, Oh-My-Zsh-Clones oder bisherigen Komplettinstallationen gestartet.

`update-subtrees.sh` ist nur noch ein abbrechender Migrationshinweis.
`install-wallpapers.sh` bleibt ein separater, explizit aufzurufender Helfer für
das private `pictures/`-Repository; es ist kein Bestandteil der Pakete.

Siehe [Paket-Anleitung](../packaging/arch/README.md).
