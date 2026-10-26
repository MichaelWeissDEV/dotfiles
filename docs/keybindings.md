# Keybindings Reference

Ghostty provides built-in keyboard shortcuts for clipboard management, font resizing, window splitting, and configuration reloading.

---

## Clipboard & Text Selection

| Shortcut | Action | Note |
| :--- | :--- | :--- |
| <kbd>Ctrl+Shift+C</kbd> *(or <kbd>Super+C</kbd> on macOS)* | Copy selected text | Copies selection to system clipboard |
| <kbd>Ctrl+Shift+V</kbd> *(or <kbd>Super+V</kbd> on macOS)* | Paste from clipboard | Pastes current system clipboard contents |
| Left Click + Drag | Select text | Automatically copies if configured |

---

## Font Scaling

| Shortcut | Action | Note |
| :--- | :--- | :--- |
| <kbd>Ctrl+=</kbd> / <kbd>Ctrl++</kbd> | Increase font size | Temporarily scales up text |
| <kbd>Ctrl+-</kbd> | Decrease font size | Temporarily scales down text |
| <kbd>Ctrl+0</kbd> | Reset font size | Restores configured `10.5pt` font size |

---

## Splits & Tabs (Native Ghostty)

If you use Ghostty without a multiplexer such as tmux:

| Shortcut | Action | Note |
| :--- | :--- | :--- |
| <kbd>Ctrl+Shift+D</kbd> | Split window horizontally | Spawns a split below |
| <kbd>Ctrl+Shift+R</kbd> | Split window vertically | Spawns a split to the right |
| <kbd>Ctrl+Shift+W</kbd> | Close active split / tab | Exits without prompt |
| <kbd>Ctrl+Shift+T</kbd> | Open new tab | Opens tab at top |
| <kbd>Ctrl+Shift+N</kbd> | Open new OS window | Spawns independent window |

:::{tip}
When working inside **tmux**, prefer tmux split and window shortcuts (<kbd>Prefix</kbd> <kbd>v</kbd> / <kbd>s</kbd> / <kbd>c</kbd>) to ensure state persists across detached sessions.
:::

---

## Configuration & Reload

| Shortcut | Action | Note |
| :--- | :--- | :--- |
| <kbd>Ctrl+Shift+,</kbd> *(or <kbd>Super+,</kbd> on macOS)* | Reload configuration | Reads `~/.config/ghostty/config` and applies immediately |
| <kbd>F11</kbd> | Toggle fullscreen | Expands to full monitor area |
