# Frequently Asked Questions & Troubleshooting

This page addresses common setup questions and edge cases when running Ghostty on Linux and macOS.

---

## Why is my background opacity not applying?

Transparency (`background-opacity = 0.90`) requires a running compositor:

- **Hyprland / Sway / Wayland**: Supported out-of-the-box. Ensure tearing or direct scanout is not disabling blending on full-screen windows.
- **X11**: Requires a compositor such as `picom`. Without a compositor, X11 renders the background fully opaque.
- **macOS**: Transparency is supported natively.

---

## Missing Nerd Font Icons

If glyphs or statusline icons appear as squares, question marks, or broken boxes:

1. Ensure `ttf-jetbrains-mono-nerd` is installed:
   ```bash
   fc-list : family | grep -i "jetbrains"
   ```
2. Check that the name in `~/.config/ghostty/config` matches:
   ```ini
   font-family = JetBrainsMono Nerd Font
   ```
3. Update font caches:
   ```bash
   fc-cache -fv
   ```

---

## Shell does not open with Zsh

The configuration specifies:
```ini
command = /usr/bin/zsh
```
If your system places Zsh at `/usr/local/bin/zsh` or if you prefer Bash:
1. Run `which zsh` or `which bash` to find the exact binary path.
2. Update the `command =` line in `~/.config/ghostty/config`.

---

## How do I toggle between Ghostty and Kitty?

Both terminals in this dotfiles ecosystem are configured with:
- Identical `JetBrainsMono Nerd Font 10.5` typography
- Matching `0.90` Catppuccin Mocha opacity
- Identical `8px` padding
- Identical color palettes

You can launch either terminal freely via Hyprland (<kbd>Super+Return</kbd> launches Kitty by default, or you can switch `terminal = "ghostty"` in `~/.config/hypr/hyprland.lua`).
