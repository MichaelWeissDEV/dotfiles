# Configuration Reference

All settings live in a single, well-documented file located at `~/.config/ghostty/config`.

---

## Typography

```ini
font-family = JetBrainsMono Nerd Font
font-size = 10.5
```

- **`font-family`**: Uses `JetBrainsMono Nerd Font` to provide complete glyph support for Neovim, tmux, Waybar, and Yazi.
- **`font-size`**: Sized at `10.5pt` to match Kitty and Foot, providing high information density while preserving legibility on both 1080p and 1440p displays.

---

## Window Appearance & Layout

```ini
command = /usr/bin/zsh
window-decoration = none
gtk-titlebar = false
window-padding-x = 8
window-padding-y = 8
window-padding-balance = true
confirm-close-surface = false
mouse-hide-while-typing = true
shell-integration-features = no-cursor
```

- **`command`**: Spawns `/usr/bin/zsh` by default. If your Zsh is located elsewhere, run `which zsh` and adjust.
- **`window-decoration`** & **`gtk-titlebar`**: Disabled (`none` and `false`). Maximizes screen real estate for tiling window managers such as Hyprland, Sway, or i3.
- **`window-padding-x`** & **`window-padding-y`**: `8px` inner margin so terminal text does not collide with window borders.
- **`window-padding-balance`**: Centers content evenly when resizing splits or windows.
- **`confirm-close-surface`**: Disabled (`false`) so closing windows or processes exits immediately without annoying popups.
- **`mouse-hide-while-typing`**: Automatically conceals the mouse pointer while typing to prevent text obstruction.
- **`shell-integration-features = no-cursor`**: Prevents the shell prompt from resetting the custom cursor color or shape.

---

## Cursor Styling

```ini
cursor-style = block
cursor-style-blink = false
cursor-color = #f5e0dc
cursor-text = #1e1e2e
adjust-cursor-thickness = 1
```

- **`cursor-style`**: Solid `block` cursor for instant visual tracking.
- **`cursor-style-blink`**: Disabled (`false`) for zero visual distraction and instant rendering.
- **`cursor-color`**: Catppuccin Rosewater (`#f5e0dc`).
- **`cursor-text`**: Catppuccin Base (`#1e1e2e`), inverted for maximum contrast against highlighted characters.

---

## Colors & Opacity

```ini
background-opacity = 0.90
background = #1e1e2e
foreground = #cdd6f4
selection-background = #89b4fa
selection-foreground = #1e1e2e
```

### Full 16-Color Palette (Catppuccin Mocha)

```ini
# Black & Dark Grey (Surface1 #45475a, Surface2 #585b70)
palette = 0=#45475a
palette = 8=#585b70

# Red (Pastel Red #f38ba8)
palette = 1=#f38ba8
palette = 9=#f38ba8

# Green (Pastel Green #a6e3a1)
palette = 2=#a6e3a1
palette = 10=#a6e3a1

# Yellow (Pastel Yellow #f9e2af)
palette = 3=#f9e2af
palette = 11=#f9e2af

# Blue (Pastel Blue #89b4fa)
palette = 4=#89b4fa
palette = 12=#89b4fa

# Magenta (Pastel Pink #f5c2e7, Mauve #cba6f7)
palette = 5=#f5c2e7
palette = 13=#cba6f7

# Cyan (Pastel Teal #94e2d5)
palette = 6=#94e2d5
palette = 14=#94e2d5

# White (Subtext #bac2de, Text #a6adc8)
palette = 7=#bac2de
palette = 15=#a6adc8
```

---

## Customizing Locally

To customize this configuration on your own machine:

1. Open `~/.config/ghostty/config` in your editor.
2. Edit any values (e.g., increase `font-size = 12` or change `background-opacity = 1.0`).
3. Save the file and reload Ghostty using <kbd>Ctrl+Shift+,</kbd> (or restart the terminal).
