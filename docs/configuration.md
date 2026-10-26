# Configuration Details

`vim-config` achieves full IDE-like ergonomics and modern aesthetics using only native Vimscript options, highlighting commands, and autocmds.

---

## Editor Behavior & Environment

```vim
set nocompatible
filetype plugin indent on
syntax enable

let mapleader = " "
let maplocalleader = "\\"
```

- **`nocompatible`**: Enables modern Vim behavior rather than strict legacy Vi compatibility.
- **`filetype plugin indent on`**: Automatically detects filetypes, applying built-in indent definitions and language runtime files.
- **`mapleader = " "`**: Sets `<Space>` as the primary leader key, matching Neovim's standard shortcut convention.

---

## UI & Visual Design

```vim
set number                  " Display line number
set relativenumber          " Enable relative numbers by default
set cursorline              " Highlight the current line
set signcolumn=yes          " Always render sign column (prevents text shift)
set scrolloff=8             " Keep at least 8 lines above/below cursor
set sidescrolloff=8         " Keep at least 8 columns to the left/right
set splitbelow              " Open horizontal splits below
set splitright              " Open vertical splits to the right
set nowrap                  " Do not wrap long lines automatically
set list                    " Render whitespace indicators
set listchars=tab:»\ ,trail:·,nbsp:␣
set pumheight=12            " Maximum autocomplete popup menu items
set cmdheight=1             " Command-line height
set laststatus=2            " Always show the statusline
set noshowmode              " Suppress default -- INSERT -- (mode is in statusline)
set showcmd                 " Display incomplete commands in bottom bar
set wildmenu                " Enhanced command-line tab completion
set wildoptions=pum         " Popup menu for command completion
set shortmess+=I            " Suppress introductory splash screen
```

### TrueColor Support

```vim
if has('termguicolors')
    set termguicolors
endif
```

Enables 24-bit RGB TrueColor output when run inside modern terminals.

---

## Indentation, Editing & Search

```vim
set mouse=a                 " Full mouse support across all modes
set encoding=utf-8          " Default to UTF-8
set expandtab               " Convert tabs to spaces
set shiftwidth=4            " Indent width: 4 spaces
set tabstop=4               " Tab column width: 4 spaces
set softtabstop=4           " Backspace deletes 4 spaces at once
set smartindent             " Smart C-like auto-indentation
set autoindent              " Copy indent from current line when starting new line
set backspace=indent,eol,start
set ignorecase              " Case-insensitive search by default
set smartcase               " Switch to case-sensitive when uppercase is typed
set incsearch               " Show search matches incrementally
set hlsearch                " Highlight all matching search patterns
set completeopt=menu,menuone,noselect,popup
set virtualedit=block       " Allow free movement in Visual Block mode (Ctrl+V)
```

---

## File Hygiene & XDG Directory Compliance

A common annoyance in default Vim configurations is stray `.swp` or `~` backup files cluttering working directories. `vim-config` disables swap files while retaining undo history safely in `~/.local/state/vim`:

```vim
set hidden                  " Switch buffers without mandatory save
set autoread                " Reload files changed outside Vim automatically
set confirm                 " Prompt to save changes instead of failing
set noswapfile              " Disable .swp files
set nobackup                " Disable backup files
set nowritebackup           " Do not create backup while writing
set updatetime=250          " Responsive background updates (250ms)
set timeoutlen=400          " Sequence timeout (400ms)
set ttimeoutlen=10          " Instant Escape handling in terminal

" Store undo history and viminfo in XDG state directory
let s:vim_state_dir = expand('~/.local/state/vim')
let s:vim_undo_dir  = s:vim_state_dir . '/undo'
if !isdirectory(s:vim_undo_dir)
    silent! call mkdir(s:vim_undo_dir, 'p', 0700)
endif
if has('persistent_undo')
    let &undodir = s:vim_undo_dir
    set undofile
endif
let &viminfofile = s:vim_state_dir . '/viminfo'
```

---

## Native Catppuccin Mocha Color Palette

Without requiring any third-party colorscheme plugins, `vim-config` applies the full Catppuccin Mocha palette through a custom initialization function:

| Palette Role | Hex Code | Description |
| :--- | :--- | :--- |
| **Base** | `#1e1e2e` | Main window background |
| **Mantle** | `#181825` | Statusline and popup background |
| **Text** | `#cdd6f4` | Primary foreground text |
| **Overlay0** | `#6c7086` | Line numbers, comments, subtle borders |
| **Surface0** | `#313244` | Split separators, menu borders |
| **Surface1** | `#45475a` | Visual selection, matching parentheses |
| **Blue** | `#89b4fa` | Functions, active line number, Normal mode |
| **Green** | `#a6e3a1` | Strings, Insert mode indicator |
| **Mauve** | `#cba6f7` | Keywords, statements, Visual mode indicator |
| **Peach** | `#fab387` | Constants, numbers, Command mode indicator |
| **Red** | `#f38ba8` | Errors, Replace mode indicator |
| **Yellow** | `#f9e2af` | Search highlight, types, modified flag |

---

## Autocommands

Two autocommands ensure workflow continuity:

1. **Cursor Position Restoration**:
   Remembers the line where you last closed a file and automatically jumps to it upon reopening:
   ```vim
   autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") && &ft !~# 'commit' |
       \   exe "normal! g`\"" |
       \ endif
   ```

2. **Split Equalization on Window Resize**:
   Automatically runs `wincmd =` when the host terminal or tiling window manager resizes the editor window:
   ```vim
   autocmd VimResized * wincmd =
   ```
