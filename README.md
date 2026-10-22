# System Configurations (`~/.config`)

Zentrales Git-Repository für alle Tool- und Desktop-Konfigurationen unter `~/.config`.

## Enthaltene Konfigurationen

- **`zsh/`** – Zsh-Hauptkonfiguration (`zshrc`), modulare Aliases & FZF-Funktionen (`aliases.zsh`: `nv`, `fznv`, `fzv`, `y`, `tm`, …) sowie das minimale Prompt-Theme (`> `)
- **`nvim/`** – Neovim-Konfiguration (Git-Submodule: `MichaelWeissDEV/nvim-config`)
- **`tmux/`** – Tmux-Konfiguration (Git-Submodule: `MichaelWeissDEV/tmux-config`)
- **`hypr/`** – Hyprland, Hyprlock, Powermenu & Askpass
- **`waybar/`** – Statusleiste
- **`foot/` & `kitty/`** – Terminal-Emulatoren
- **`fuzzel/`** – Application Launcher
- **`yazi/`** – Terminal-Dateimanager
- **`gtk-3.0/`, `gtk-4.0/`, `pcmanfm/`, `libfm/`, `xfce4/`** – GTK & Dateimanager-Einstellungen

## Auf einem neuen System einrichten

```bash
git clone --recurse-submodules <REPO-URL> ~/.config
~/.config/install-links.sh
```
