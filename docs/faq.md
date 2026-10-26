# Frequently Asked Questions

This section answers common questions regarding Kitty, its configuration, Wayland compositing, font rendering, and clipboard integration across local and remote sessions.

---

## Configuration & Reloading

### How do I reload the Kitty configuration without restarting?

Press:
```
Ctrl + Shift + F5
```
Alternatively, if remote control is enabled or you wish to reload from a terminal command:
```bash
kill -SIGUSR1 $(pgrep -f "kitty")
```

All color palette changes, tab styles, and font sizes will update immediately in the active window.

---

## Display & Compositing

### Why is the background transparency not working?

Kitty sets `background_opacity 0.90`. For opacity to take effect:

1. **Wayland**: You must run a Wayland compositor that supports alpha blending (e.g., Hyprland, Sway, GNOME Wayland). On Hyprland, Kitty's opacity is automatically respected.
2. **X11**: A compositing manager such as `picom` or `xcompmgr` must be running.
3. **Display Server Setting**: If Kitty falls back to XWayland unintentionally, you can force native Wayland rendering in `kitty.conf`:
   ```ini
   linux_display_server wayland
   ```

### How do I adjust opacity dynamically on the fly?

The configuration enables `dynamic_background_opacity yes`. You can adjust opacity interactively if remote control is active:
```bash
kitty @ set-background-opacity 1.0   # Solid background
kitty @ set-background-opacity 0.85  # Increased transparency
```

---

## Typography & Icons

### Why do some icons or powerline glyphs appear broken?

The configuration relies on **JetBrainsMono Nerd Font**:
- Ensure the font package is installed on your operating system:
  ```bash
  # Arch Linux
  sudo pacman -S ttf-jetbrains-mono-nerd

  # Debian / Ubuntu
  sudo apt install fonts-jetbrains-mono
  ```
- If symbols still do not render, verify available font families in Kitty:
  ```bash
  kitty +list-fonts --psnames | grep -i jetbrains
  ```

---

## Clipboard & SSH Workflows

### How does copy/paste work in Kitty?

In Kitty, copy and paste use the dedicated shortcuts:
- **Copy**: `Ctrl + Shift + C` (or simply selecting text with the mouse if mouse copy is enabled)
- **Paste**: `Ctrl + Shift + V`

### How can I copy text over SSH sessions?

Kitty supports the **OSC 52** ANSI escape sequence for clipboard synchronization out-of-the-box. When connecting to remote servers, using the `kitten ssh` wrapper ensures full terminal capabilities, shell integration, and automatic terminfo installation:

```bash
kitty +kitten ssh user@remote-host
```

In `tmux` running over SSH, ensure `set -s set-clipboard on` is enabled (already configured in our [tmux-config](https://tmux-config.readthedocs.io/en/latest/)).

---

## Scrollback & Pagers

### How do I search and browse terminal history?

Press:
```
Ctrl + Shift + H
```
Kitty opens your full scrollback buffer in your configured pager (or Neovim), allowing standard search (`/pattern`), visual line selection, and seamless buffer extraction.

---

## Kitty vs. Ghostty: When to use which?

Both Kitty and Ghostty are configured with identical Catppuccin Mocha aesthetics and `0.90` opacity in this dotfiles ecosystem:
- **Kitty**: Highly mature, supports rich kitten scripts, interactive remote control, extensive graphics protocol (`kitty icat`), and widespread package repository availability.
- **Ghostty**: Ultra-modern Zig codebase, built-in native macOS and GTK4 interfaces, native tab rendering, and fast startup times.

You can switch seamlessly between both terminals at any time.
