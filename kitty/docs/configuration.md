# Configuration Reference

All settings are defined in `~/.config/kitty/kitty.conf`.

---

## Typography

```conf
font_family      JetBrainsMonoNL Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        10.5
disable_ligatures always
```

- **`font_family`**: `JetBrainsMonoNL Nerd Font` (`No Ligatures` variant) provides sharp code rendering and full glyph coverage without operator ligatures (`==`, `->`) or shifted characters (`*`).
- **`bold_font` / `italic_font`**: Automatically selects the corresponding font weight/slant.
- **`font_size`**: `10.5pt` balances information density and legibility.
- **`disable_ligatures always`**: Ensures programming ligatures are completely disabled at all times.

---

## Window Behavior & Margins

```conf
shell                   /usr/bin/zsh
window_padding_width    8
confirm_os_window_close 0
enable_audio_bell       no
cursor_shape            block
cursor_blink_interval   0
url_style               straight
```

- **`shell`**: Launches `/usr/bin/zsh` upon opening.
- **`window_padding_width`**: `8px` inner margin so code does not touch window borders.
- **`confirm_os_window_close 0`**: Exits immediately without confirmation popups.
- **`enable_audio_bell no`**: Silences terminal beeps.
- **`cursor_shape block`** & **`cursor_blink_interval 0`**: Solid, non-blinking block cursor.
- **`url_style straight`**: Underlines clickable URLs with a clean straight line.

---

## Transparency & Colors

```conf
background_opacity         0.90
dynamic_background_opacity yes
```

- **`background_opacity 0.90`**: Soft `10%` transparency against the wallpaper/desktop.
- **`dynamic_background_opacity yes`**: Enables runtime opacity adjustments.

### Catppuccin Mocha Palette

```conf
# Foreground & Background
foreground              #cdd6f4
background              #1e1e2e
selection_foreground    #1e1e2e
selection_background    #89b4fa

# Cursor
cursor                  #f5e0dc
cursor_text_color       #1e1e2e

# URLs
url_color               #89b4fa

# Window Borders
active_border_color     #89b4fa
inactive_border_color   #313244
bell_border_color       #f38ba8

# Tab Bar
active_tab_foreground   #11111b
active_tab_background   #89b4fa
inactive_tab_foreground #cdd6f4
inactive_tab_background #181825
tab_bar_background      #11111b
tab_bar_style           powerline

# 16-color ANSI Palette
color0  #45475a
color8  #585b70
color1  #f38ba8
color9  #f38ba8
color2  #a6e3a1
color10 #a6e3a1
color3  #f9e2af
color11 #f9e2af
color4  #89b4fa
color12 #89b4fa
color5  #f5c2e7
color13 #cba6f7
color6  #94e2d5
color14 #94e2d5
color7  #bac2de
color15 #a6adc8
```
