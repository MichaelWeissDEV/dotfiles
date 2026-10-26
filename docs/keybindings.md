# Keybindings & Commands

`vim-config` adopts the modern leader-based keybinding paradigm where `<Space>` acts as the primary leader key (`mapleader = " "`). All shortcuts are synchronized with `nvim-config` to maintain identical muscle memory across both editors.

---

## Window Navigation & Splits

Move seamlessly between panes without reaching for the default `Ctrl+w` chord:

| Keybinding | Mode | Action | Command Equivalent |
| :--- | :--- | :--- | :--- |
| <kbd>Ctrl</kbd> + <kbd>h</kbd> | Normal | Focus window to the left | `<C-w>h` |
| <kbd>Ctrl</kbd> + <kbd>j</kbd> | Normal | Focus window below | `<C-w>j` |
| <kbd>Ctrl</kbd> + <kbd>k</kbd> | Normal | Focus window above | `<C-w>k` |
| <kbd>Ctrl</kbd> + <kbd>l</kbd> | Normal | Focus window to the right | `<C-w>l` |
| <kbd>Space</kbd> + <kbd>w</kbd> <kbd>v</kbd> | Normal | Split window vertically | `:vsplit` |
| <kbd>Space</kbd> + <kbd>w</kbd> <kbd>s</kbd> | Normal | Split window horizontally | `:split` |
| <kbd>Space</kbd> + <kbd>w</kbd> <kbd>c</kbd> | Normal | Close active window | `:close` |
| <kbd>Space</kbd> + <kbd>w</kbd> <kbd>e</kbd> | Normal | Equalize all window sizes | `<C-w>=` |

---

## Buffer Navigation & Management

Switch between open files as fast as tab switching:

| Keybinding | Mode | Action | Command Equivalent |
| :--- | :--- | :--- | :--- |
| <kbd>Shift</kbd> + <kbd>h</kbd> (`H`) | Normal | Navigate to previous buffer | `:bprevious` |
| <kbd>Shift</kbd> + <kbd>l</kbd> (`L`) | Normal | Navigate to next buffer | `:bnext` |
| <kbd>Space</kbd> + <kbd>b</kbd> <kbd>d</kbd> | Normal | Close/delete active buffer | `:bdelete` |

---

## Line Numbers & UI Toggles

Toggle display attributes instantly during presentation, debugging, or copying code:

| Keybinding | Mode | Action | Notes |
| :--- | :--- | :--- | :--- |
| <kbd>Space</kbd> + <kbd>u</kbd> <kbd>n</kbd> | Normal | Toggle Relative ↔ Absolute | Cycles between hybrid relative and absolute |
| <kbd>Space</kbd> + <kbd>r</kbd> <kbd>n</kbd> | Normal | Toggle Relative ↔ Absolute | Alias for `un` |
| <kbd>Space</kbd> + <kbd>n</kbd> | Normal | Toggle Relative ↔ Absolute | Short alias |
| <kbd>F3</kbd> | Normal / Insert | Toggle Relative ↔ Absolute | Functional key toggle |
| <kbd>Space</kbd> + <kbd>u</kbd> <kbd>N</kbd> | Normal | Toggle Line Numbers On / Off | Hides or shows line numbers entirely |
| <kbd>Space</kbd> + <kbd>u</kbd> <kbd>w</kbd> | Normal | Toggle Line Wrapping | `:set wrap!` |
| <kbd>Space</kbd> + <kbd>u</kbd> <kbd>l</kbd> | Normal | Toggle Invisible Characters | `:set list!` (tabs, trailing spaces) |
| <kbd>Esc</kbd> | Normal | Clear Search Highlights | `:nohlsearch` |

---

## Clipboard & Editing Comfort

| Keybinding | Mode | Action | Notes |
| :--- | :--- | :--- | :--- |
| <kbd>Space</kbd> + <kbd>y</kbd> | Normal / Visual | Copy selection to system clipboard | Uses `"+y` register |
| <kbd>Space</kbd> + <kbd>Y</kbd> | Normal | Copy line to system clipboard | Uses `"+Y` register |
| <kbd>&lt;</kbd> | Visual | Unindent block | Retains visual selection (`<gv`) |
| <kbd>&gt;</kbd> | Visual | Indent block | Retains visual selection (`>gv`) |
| <kbd>Ctrl</kbd> + <kbd>d</kbd> | Normal | Scroll half page down | Automatically centers viewport (`zz`) |
| <kbd>Ctrl</kbd> + <kbd>u</kbd> | Normal | Scroll half page up | Automatically centers viewport (`zz`) |

---

## Custom Commands

| Command | Description |
| :--- | :--- |
| `:ToggleRelNum` | Programmatically toggle between relative and absolute line numbering, updating the statusline state. |
