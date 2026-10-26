# Keybindings Reference

Kitty provides responsive shortcuts for managing tabs, windows, scrollback navigation, font sizing, and configuration reloading.

---

## Tabs & Windows

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| <kbd>Ctrl+Shift+T</kbd> | New tab | Spawns a new tab in the current working directory |
| <kbd>Ctrl+Shift+Q</kbd> | Close tab | Closes the active tab immediately |
| <kbd>Ctrl+Shift+Right</kbd> | Next tab | Moves focus to the tab to the right |
| <kbd>Ctrl+Shift+Left</kbd> | Previous tab | Moves focus to the tab to the left |
| <kbd>Ctrl+Shift+Enter</kbd> | New window | Spawns a split window inside Kitty |
| <kbd>Ctrl+Shift+W</kbd> | Close window | Closes the active split |

---

## Clipboard & Selection

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| <kbd>Ctrl+Shift+C</kbd> | Copy selection | Copies highlighted text to the clipboard |
| <kbd>Ctrl+Shift+V</kbd> | Paste | Pastes from system clipboard |
| <kbd>Ctrl+Shift+S</kbd> | Paste from selection | Pastes from the primary X11/Wayland selection |

---

## Font Sizing & Display

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| <kbd>Ctrl+Shift+=</kbd> / <kbd>Ctrl+Shift++</kbd> | Increase font | Increases font size by 1pt |
| <kbd>Ctrl+Shift+-</kbd> | Decrease font | Decreases font size by 1pt |
| <kbd>Ctrl+Shift+Backspace</kbd> | Reset font | Restores default `10.5pt` font size |

---

## Scrolling & Reload

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| <kbd>Ctrl+Shift+Up</kbd> / <kbd>PageUp</kbd> | Scroll up | Scrolls one line/page upwards |
| <kbd>Ctrl+Shift+Down</kbd> / <kbd>PageDown</kbd> | Scroll down | Scrolls one line/page downwards |
| <kbd>Ctrl+Shift+Home</kbd> | Scroll to top | Jumps to beginning of scrollback |
| <kbd>Ctrl+Shift+End</kbd> | Scroll to bottom | Jumps back to active prompt |
| <kbd>Ctrl+Shift+F5</kbd> | Reload configuration | Live reloads `~/.config/kitty/kitty.conf` without closing terminal |
