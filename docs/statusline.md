# Dynamic Statusline

`vim-config` features a modular, zero-plugin statusline built entirely with native Vimscript expressions and dynamic highlight evaluation.

---

## Visual Architecture

```text
┌───────────┬───────────────┬─────┬─────────┬─────────────────────────┬──────────────┐
│  NORMAL   │ path/file.lua │ [+] │         │ NUM:REL │ lua │ utf-8 │ │ 42:15 (28%)  │
└───────────┴───────────────┴─────┴─────────┴─────────────────────────┴──────────────┘
  (Mode)         (File)      (Mod)  (Spacer)  (Num)       (Metadata)        (Pos)
```

The statusline contains six logical components:

1. **Live Mode Pill**: Color-coded pill displaying current editing mode.
2. **File Name & Path**: Relative path of the active buffer (`%f`).
3. **Modified & Read-Only Flags**: High-contrast indicator for unsaved edits (`[+]`) or read-only files (`[RO]`).
4. **Spacer (`%=`)**: Right-aligns all remaining telemetry.
5. **Line Number State Indicator**: Displays current numbering configuration (`NUM:REL`, `NUM:ABS`, or `NUM:OFF`).
6. **File Metadata & Position**: Filetype (`lua`, `python`, `vim`), encoding (`utf-8`), format (`unix`), and line:column coordinates with buffer percentage (`42:15 (28%)`).

---

## Native Implementation

The entire statusline is composed through an expression evaluation function `BuildStatusLine()`:

```vim
function! BuildStatusLine() abort
    let l:stl  = '%{StlModeColor()}%{StlModeLabel()}'
    let l:stl .= '%#StlSectionFile# %f %*'
    let l:stl .= '%#StlSectionModified#%{&modified ? "[+] " : ""}%{&readonly ? "[RO] " : ""}%*'
    let l:stl .= '%#StlSectionMid#%='
    let l:stl .= '%#StlSectionNumMode#%{StlLineNumberMode()}'
    let l:stl .= '%#StlSectionFile# %{&filetype != "" ? &filetype : "plain"} │ %{&fileencoding != "" ? &fileencoding : &encoding} │ %{&fileformat} '
    let l:stl .= '%#StlSectionPos# %l:%v (%p%%) '
    return l:stl
endfunction

set statusline=%!BuildStatusLine()
```

---

## Dynamic Mode Detection & Coloring

As you transition between modes, `StlModeLabel()` and `StlModeColor()` re-evaluate on every cursor tick or mode shift:

| Mode | Label | Highlight Group | Background Color |
| :--- | :--- | :--- | :--- |
| **Normal** | `NORMAL` | `StlModeNormal` | Catppuccin Blue (`#89b4fa`) |
| **Insert** | `INSERT` | `StlModeInsert` | Catppuccin Green (`#a6e3a1`) |
| **Visual (Char)** | `VISUAL` | `StlModeVisual` | Catppuccin Mauve (`#cba6f7`) |
| **Visual (Line)** | `V-LINE` | `StlModeVisual` | Catppuccin Mauve (`#cba6f7`) |
| **Visual (Block)** | `V-BLOCK` | `StlModeVisual` | Catppuccin Mauve (`#cba6f7`) |
| **Replace** | `REPLACE` | `StlModeReplace` | Catppuccin Red (`#f38ba8`) |
| **Command** | `COMMAND` | `StlModeCommand` | Catppuccin Peach (`#fab387`) |
| **Terminal** | `TERMINAL` | `StlModeNormal` | Catppuccin Blue (`#89b4fa`) |

---

## Line Number Telemetry

The `StlLineNumberMode()` function queries Vim's buffer options to provide live feedback:

```vim
function! StlLineNumberMode() abort
    if !&number && !&relativenumber
        return ' NUM:OFF '
    elseif &relativenumber
        return ' NUM:REL '
    else
        return ' NUM:ABS '
    endif
endfunction
```

Whenever you toggle numbering with `<Space>un` or `<F3>`, the statusline immediately reflects the new mode without requiring screen redrawing artifacts.
