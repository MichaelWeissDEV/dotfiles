# Terminal Emulators

The dotfiles ecosystem provides three pre-configured terminal emulators: **Ghostty**, **Kitty**, and **Foot**. Each is tuned to deliver identical typography, window transparency, and color fidelity.

---

## Shared Aesthetic Standards

Regardless of which terminal emulator is active, you experience consistent visual behavior:

- 🎨 **Palette**: Official **Catppuccin Mocha** pastel colors (`#1e1e2e` base, `#cdd6f4` text, `#89b4fa` pastel blue).
- 🪟 **Transparency**: Uniform `0.90` background opacity for smooth compositing on Wayland.
- 🔤 **Typography**: **JetBrainsMono Nerd Font** (10.5pt - 11pt) with complete powerline glyphs and ligatures.
- 🐚 **Default Shell**: Automatically launches into `/usr/bin/zsh` with Oh My Zsh.
- 🔔 **Bell**: Audio bell disabled across all emulators (`enable_audio_bell no`, `bell=none`).

---

## Terminal Comparison & Roles

| Feature | Ghostty | Kitty | Foot |
| :--- | :--- | :--- | :--- |
| **Engine / Architecture** | Zig + OpenGL/Vulkan | C/Python + OpenGL | C + Wayland Native |
| **Memory Footprint** | Low (~35 MB) | Moderate (~50 MB) | Ultra-Low (~15 MB) |
| **Wayland Support** | Native Wayland (GTK4) | Native Wayland | Native Wayland |
| **Tab Management** | Native GTK4 tabs | Powerline tabs | Multiplexer (tmux) |
| **Scripting / Kittens** | CLI parameters | Kitten scripts & IPC | Client-server daemon |
| **Documentation** | [Ghostty Docs](https://ghostty-config.readthedocs.io/en/latest/) | [Kitty Docs](https://kittiy-config.readthedocs.io/en/latest/) | Built-in man pages |

---

## Terminal Details

### 1. Ghostty (`~/.config/ghostty/config`)

Managed via the Git subtree `MichaelWeissDEV/ghostty-config`. Ghostty is an ultra-modern terminal written in Zig featuring native GTK4 rendering, GPU shaders, and native Wayland fractional scaling.

- **Config path**: `~/.config/ghostty/config`
- **Documentation**: [ghostty-config Documentation](https://ghostty-config.readthedocs.io/en/latest/)

### 2. Kitty (`~/.config/kitty/kitty.conf`)

Managed via the Git subtree `MichaelWeissDEV/kittiy-config`. Kitty provides mature graphics protocols, extensive kitten automation scripts, and custom Powerline tab bar rendering.

- **Config path**: `~/.config/kitty/kitty.conf`
- **Documentation**: [kittiy-config Documentation](https://kittiy-config.readthedocs.io/en/latest/)

### 3. Foot (`~/.config/foot/foot.ini`)

Foot is a lightweight, minimalist terminal designed strictly for Wayland. It starts instantaneously and operates with minimal CPU and memory overhead.

- **Config path**: `~/.config/foot/foot.ini`

---

## Selecting Your Default Terminal

In Hyprland, the default terminal shortcut (<kbd>Super</kbd> + <kbd>Return</kbd>) is bound to Kitty:

```lua
-- ~/.config/hypr/hyprland.lua
local terminal = "kitty"
```

To switch your default to Ghostty or Foot, update the `terminal` variable in `hyprland.lua` and reload Hyprland.
