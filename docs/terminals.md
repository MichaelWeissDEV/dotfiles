# Terminal Emulators

The [`arch-dotfiles`](https://arch-dotfiles.readthedocs.io/en/latest/) ecosystem provides three pre-configured terminal emulators: **Ghostty**, **Kitty**, and **Foot**. Each is tuned to deliver identical typography, window transparency, and **Catppuccin Mocha** color fidelity.

---

## Shared Aesthetic Standards

Regardless of which terminal emulator is active, you experience consistent visual behavior:

- 🎨 **Palette**: Official **Catppuccin Mocha** pastel colors (`#1e1e2e` base, `#cdd6f4` text, `#89b4fa` pastel blue selection, `#f5e0dc` rosewater block cursor).
- 🪟 **Transparency**: Uniform `0.90` background opacity for smooth compositing on Wayland.
- 🔤 **Typography**: **JetBrainsMono Nerd Font** (`10.5pt`) with `8px` window padding and complete Powerline/Nerd Font glyphs.
- 🐚 **Default Shell**: Automatically launches into `/usr/bin/zsh` with Oh My Zsh.
- 🔔 **Bell**: Audio bell disabled across all emulators (`enable_audio_bell no`, `urgent=no`).

---

## Terminal Comparison & Documentation Links

| Feature | Ghostty | Kitty | Foot |
| :--- | :--- | :--- | :--- |
| **Engine / Architecture** | Zig + OpenGL/Vulkan | C/Python + OpenGL | C + Wayland Native |
| **Memory Footprint** | Low (~35 MB) | Moderate (~50 MB) | Ultra-Low (~15 MB) |
| **Wayland Support** | Native Wayland (GTK4) | Native Wayland | Native Wayland |
| **Tab Management** | Native GTK4 tabs | Powerline tabs | Multiplexer ([tmux](https://tmux-config.readthedocs.io/en/latest/)) |
| **Config Reload Shortcut** | <kbd>Ctrl+Shift+,</kbd> | <kbd>Ctrl+Shift+F5</kbd> | Automatic / restart |
| **Repository** | [MichaelWeissDEV/ghostty-config](https://github.com/MichaelWeissDEV/ghostty-config) | [MichaelWeissDEV/kittiy-config](https://github.com/MichaelWeissDEV/kittiy-config) | Included in `foot/` |
| **Documentation** | [**ghostty-config.readthedocs.io**](https://ghostty-config.readthedocs.io/en/latest/) | [**kitty-config.readthedocs.io**](https://kitty-config.readthedocs.io/en/latest/) | Built-in man pages (`man foot.ini`) |

---

## Terminal Details

### 1. Ghostty (`~/.config/ghostty/config`)

Managed via the Git subtree `MichaelWeissDEV/ghostty-config` (`arch-dot subtrees ghostty`). Ghostty is a modern GPU-accelerated terminal written in Zig featuring native GTK4/Wayland rendering and zero window decorations (`window-decoration = none`).

- **Config path**: `~/.config/ghostty/config`
- **README**: [`ghostty/README.md`](https://github.com/MichaelWeissDEV/ghostty-config)
- **Full Documentation**: [ghostty-config.readthedocs.io](https://ghostty-config.readthedocs.io/en/latest/)

### 2. Kitty (`~/.config/kitty/kitty.conf`)

Managed via the Git subtree `MichaelWeissDEV/kittiy-config` (`arch-dot subtrees kitty`). Kitty provides mature graphics protocols, kitten automation scripts, dynamic background opacity, and a custom Catppuccin Powerline tab bar.

- **Config path**: `~/.config/kitty/kitty.conf`
- **README**: [`kitty/README.md`](https://github.com/MichaelWeissDEV/kittiy-config)
- **Full Documentation**: [kitty-config.readthedocs.io](https://kitty-config.readthedocs.io/en/latest/)

### 3. Foot (`~/.config/foot/foot.ini`)

Foot is an ultra-lightweight terminal designed strictly for Wayland. It starts instantaneously and operates with minimal CPU and memory overhead.

- **Config path**: `~/.config/foot/foot.ini`

---

## Selecting Your Default Terminal in Hyprland

In Hyprland (`~/.config/hypr/hyprland.lua`), the default terminal shortcut (<kbd>Super</kbd> + <kbd>Return</kbd> or <kbd>Super</kbd> + <kbd>Q</kbd>) is bound to Kitty:

```lua
-- ~/.config/hypr/hyprland.lua
local terminal = "kitty"
```

To switch your default terminal to Ghostty or Foot, change `local terminal = "ghostty"` (or `"foot"`) in `hyprland.lua`.
