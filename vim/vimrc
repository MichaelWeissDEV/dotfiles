" ============================================================================
" ~/.config/vim/vimrc - Minimalistische Vim-Konfiguration (Catppuccin Mocha)
" Synchronisiert mit den Optionen & Keymaps aus ~/.config/nvim
" ============================================================================

set nocompatible
filetype plugin indent on
syntax enable

" Leader-Tasten (identisch zu Neovim: <Space> als Leader, \ als LocalLeader)
let mapleader = " "
let maplocalleader = "\\"

" ============================================================================
" UI & DARSTELLUNG
" ============================================================================
set number                  " Aktuelle Zeilennummer anzeigen
set relativenumber          " Relative Zeilennummern standardmäßig aktiv
set cursorline              " Aktuelle Zeile hervorheben
set signcolumn=yes          " Sign-Spalte immer anzeigen (verhindert Springen)
set scrolloff=8             " Mindestens 8 Zeilen Abstand oben/unten beim Scrollen
set sidescrolloff=8         " Mindestens 8 Spalten Abstand links/rechts
set splitbelow              " Horizontale Splits unten öffnen
set splitright              " Vertikale Splits rechts öffnen
set nowrap                  " Kein automatischer Zeilenumbruch
set list                    " Unsichtbare Zeichen dezent darstellen
set listchars=tab:»\ ,trail:·,nbsp:␣
set pumheight=12            " Maximale Höhe des Autocomplete-Popups
set cmdheight=1             " Befehlszeile 1 Zeile hoch
set laststatus=2            " Statuszeile unten immer anzeigen
set noshowmode              " Modus steht bereits farbig in der Statuszeile
set showcmd                 " Eingetippte Befehle rechts unten anzeigen
set wildmenu                " Verbesserte Tab-Vervollständigung in der Befehlszeile
set wildoptions=pum         " Popup-Menü für Befehlszeilen-Vervollständigung
set shortmess+=I            " Kein Intro-Startbildschirm

if has('termguicolors')
    set termguicolors
endif

" ============================================================================
" EDITIEREN & SUCHE
" ============================================================================
set mouse=a                 " Mausunterstützung in allen Modi
set encoding=utf-8          " UTF-8 Standardkodierung
set expandtab               " Tabs in Leerzeichen umwandeln
set shiftwidth=4            " Einrückung: 4 Leerzeichen
set tabstop=4               " Tab-Breite: 4 Leerzeichen
set softtabstop=4           " Backspace löscht 4 Leerzeichen auf einmal
set smartindent             " Intelligentes Einrücken
set autoindent              " Einrückung der Vorzeile übernehmen
set backspace=indent,eol,start
set ignorecase              " Groß-/Kleinschreibung bei Suche ignorieren...
set smartcase               " ...außer es werden Großbuchstaben getippt
set incsearch               " Live-Vorschau während der Suche
set hlsearch                " Suchtreffer hervorheben
set completeopt=menu,menuone,noselect,popup
set virtualedit=block       " Freie Bewegung im Visual-Block-Modus (CTRL-V)

" System-Zwischenablage nutzen (falls +clipboard verfügbar)
if has('clipboard')
    set clipboard=unnamedplus,unnamed
endif

" ============================================================================
" DATEIEN, PERSISTENZ & XDG-SAUBERKEIT (kein Müll in ~)
" ============================================================================
set hidden                  " Buffer wechseln ohne Speichern-Zwang
set autoread                " Geänderte Dateien automatisch neu laden
set confirm                 " Nachfragen statt Fehler bei ungespeicherten Änderungen
set noswapfile              " Keine .swp-Dateien erzeugen
set nobackup                " Keine Backup-Dateien erzeugen
set nowritebackup           " Kein temporäres Backup beim Überschreiben
set updatetime=250          " Schnellere Reaktionszeit (250ms)
set timeoutlen=400          " Timeout für Keymap-Sequenzen (400ms)
set ttimeoutlen=10          " Schnelles Escape im Terminal

" Persistent Undo & Viminfo sauber unter ~/.local/state/vim ablegen
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

" ============================================================================
" CATPPUCCIN MOCHA FARBSCHEMA (Nativer Support ohne externe Plugins)
" ============================================================================
set background=dark
silent! colorscheme habamax

function! s:ApplyCatppuccinMocha() abort
    " Basis-Hintergrund & Text (Base #1e1e2e, Text #cdd6f4, Mantle #181825)
    highlight Normal       guifg=#cdd6f4 guibg=#1e1e2e ctermbg=NONE
    highlight NonText      guifg=#45475a guibg=#1e1e2e ctermbg=NONE
    highlight SpecialKey   guifg=#45475a guibg=NONE
    highlight EndOfBuffer  guifg=#1e1e2e guibg=#1e1e2e
    highlight CursorLine   guibg=#2a2b3c cterm=NONE
    highlight ColorColumn  guibg=#313244

    " Zeilennummern & Sign-Spalte (Overlay0 #6c7086, Aktive Zeile Blue #89b4fa)
    highlight LineNr       guifg=#6c7086 guibg=#1e1e2e
    highlight CursorLineNr guifg=#89b4fa guibg=#2a2b3c gui=bold cterm=bold
    highlight SignColumn   guifg=#6c7086 guibg=#1e1e2e

    " Auswahl, Suche & Klammern (Surface1 #45475a, Peach #fab387, Yellow #f9e2af)
    highlight Visual       guibg=#45475a gui=NONE
    highlight Search       guifg=#11111b guibg=#f9e2af gui=NONE
    highlight IncSearch    guifg=#11111b guibg=#fab387 gui=bold
    highlight CurSearch    guifg=#11111b guibg=#fab387 gui=bold
    highlight MatchParen   guifg=#fab387 guibg=#45475a gui=bold

    " Fensterrahmen & Popup-Menü (Surface0 #313244, Blue #89b4fa)
    highlight VertSplit    guifg=#313244 guibg=#1e1e2e gui=NONE
    highlight WinSeparator guifg=#313244 guibg=#1e1e2e gui=NONE
    highlight Pmenu        guifg=#cdd6f4 guibg=#181825
    highlight PmenuSel     guifg=#11111b guibg=#89b4fa gui=bold
    highlight PmenuSbar    guibg=#313244
    highlight PmenuThumb   guibg=#6c7086

    " Syntax-Farben (Catppuccin Mocha Pastellpalette)
    highlight Comment      guifg=#6c7086 gui=italic
    highlight Constant     guifg=#fab387
    highlight String       guifg=#a6e3a1
    highlight Character    guifg=#94e2d5
    highlight Number       guifg=#fab387
    highlight Boolean      guifg=#fab387
    highlight Identifier   guifg=#cdd6f4
    highlight Function     guifg=#89b4fa gui=bold
    highlight Statement    guifg=#cba6f7 gui=NONE
    highlight Conditional  guifg=#cba6f7 gui=NONE
    highlight Repeat       guifg=#cba6f7 gui=NONE
    highlight Keyword      guifg=#cba6f7 gui=NONE
    highlight Operator     guifg=#89dceb
    highlight PreProc      guifg=#f5c2e7
    highlight Type         guifg=#f9e2af gui=NONE
    highlight Special      guifg=#f5c2e7
    highlight Error        guifg=#f38ba8 guibg=NONE gui=bold
    highlight Todo         guifg=#11111b guibg=#f9e2af gui=bold
    highlight Directory    guifg=#89b4fa gui=bold

    " Statuszeilen-Farbgruppen (für Modi & Segmente)
    highlight StatusLine          guifg=#cdd6f4 guibg=#181825 gui=NONE
    highlight StatusLineNC        guifg=#6c7086 guibg=#181825 gui=NONE
    highlight StlModeNormal       guifg=#11111b guibg=#89b4fa gui=bold
    highlight StlModeInsert       guifg=#11111b guibg=#a6e3a1 gui=bold
    highlight StlModeVisual       guifg=#11111b guibg=#cba6f7 gui=bold
    highlight StlModeReplace      guifg=#11111b guibg=#f38ba8 gui=bold
    highlight StlModeCommand      guifg=#11111b guibg=#fab387 gui=bold
    highlight StlSectionMid       guifg=#cdd6f4 guibg=#181825 gui=NONE
    highlight StlSectionFile      guifg=#cdd6f4 guibg=#313244 gui=NONE
    highlight StlSectionModified  guifg=#f9e2af guibg=#313244 gui=bold
    highlight StlSectionNumMode   guifg=#94e2d5 guibg=#313244 gui=bold
    highlight StlSectionPos       guifg=#11111b guibg=#89b4fa gui=bold
endfunction

call s:ApplyCatppuccinMocha()

" ============================================================================
" STATUSZEILE UNTEN (Mit Live-Modus, Datei-Infos & REL/ABS-Indikator)
" ============================================================================
function! StlModeLabel() abort
    let l:m = mode()
    if l:m ==# 'n' || l:m ==# 'no'
        return ' NORMAL '
    elseif l:m ==# 'i' || l:m ==# 'ic'
        return ' INSERT '
    elseif l:m ==# 'v'
        return ' VISUAL '
    elseif l:m ==# 'V'
        return ' V-LINE '
    elseif l:m ==# "\<C-v>"
        return ' V-BLOCK '
    elseif l:m ==# 'R' || l:m ==# 'Rv'
        return ' REPLACE '
    elseif l:m ==# 'c'
        return ' COMMAND '
    elseif l:m ==# 't'
        return ' TERMINAL '
    endif
    return ' ' . toupper(l:m) . ' '
endfunction

function! StlModeColor() abort
    let l:m = mode()
    if l:m ==# 'i' || l:m ==# 'ic'
        return '%#StlModeInsert#'
    elseif l:m ==# 'v' || l:m ==# 'V' || l:m ==# "\<C-v>"
        return '%#StlModeVisual#'
    elseif l:m ==# 'R' || l:m ==# 'Rv'
        return '%#StlModeReplace#'
    elseif l:m ==# 'c'
        return '%#StlModeCommand#'
    endif
    return '%#StlModeNormal#'
endfunction

function! StlLineNumberMode() abort
    if !&number && !&relativenumber
        return ' NUM:OFF '
    elseif &relativenumber
        return ' NUM:REL '
    else
        return ' NUM:ABS '
    endif
endfunction

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

" ============================================================================
" ZEILENNUMMERN: UMSCHALTEN ZWISCHEN RELATIV & ABSOLUT
" ============================================================================
function! ToggleRelativeAbsoluteNumbers() abort
    if !&number && !&relativenumber
        set number
        set relativenumber
        echo "Zeilennummern: Relativ (Hybrid)"
    elseif &relativenumber
        set number
        set norelativenumber
        echo "Zeilennummern: Absolut"
    else
        set number
        set relativenumber
        echo "Zeilennummern: Relativ (Hybrid)"
    endif
    redrawstatus
endfunction

function! ToggleNumbersOff() abort
    if &number || &relativenumber
        set nonumber
        set norelativenumber
        echo "Zeilennummern: Aus"
    else
        set number
        set relativenumber
        echo "Zeilennummern: Relativ (Hybrid)"
    endif
    redrawstatus
endfunction

command! ToggleRelNum call ToggleRelativeAbsoluteNumbers()

" <Space>un (wie in Neovim), <Space>rn, <Space>n oder <F3>: Relativ <-> Absolut umschalten
nnoremap <silent> <leader>un :call ToggleRelativeAbsoluteNumbers()<CR>
nnoremap <silent> <leader>rn :call ToggleRelativeAbsoluteNumbers()<CR>
nnoremap <silent> <leader>n  :call ToggleRelativeAbsoluteNumbers()<CR>
nnoremap <silent> <F3>       :call ToggleRelativeAbsoluteNumbers()<CR>
inoremap <silent> <F3>       <C-o>:call ToggleRelativeAbsoluteNumbers()<CR>

" <Space>uN (wie in Neovim): Zeilennummern komplett an/aus
nnoremap <silent> <leader>uN :call ToggleNumbersOff()<CR>

" ============================================================================
" WEITERE KEYMAPS (Synchronisiert mit ~/.config/nvim/lua/config/keymaps.lua)
" ============================================================================
" Fenster-Navigation mit CTRL + h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Fenster-Splits (<Space>wv / ws / wc / we)
nnoremap <silent> <leader>wv :vsplit<CR>
nnoremap <silent> <leader>ws :split<CR>
nnoremap <silent> <leader>wc :close<CR>
nnoremap <silent> <leader>we <C-w>=

" Buffer-Navigation mit SHIFT + H / L & Buffer schließen (<Space>bd)
nnoremap <silent> <S-h>      :bprevious<CR>
nnoremap <silent> <S-l>      :bnext<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

" UI-Toggles: Zeilenumbruch (<Space>uw) & Unsichtbare Zeichen (<Space>ul)
nnoremap <silent> <leader>uw :set wrap!<CR>
nnoremap <silent> <leader>ul :set list!<CR>

" Suchhervorhebung mit <Esc> ausblenden
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" System-Zwischenablage (<Space>y / <Space>Y)
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Einrücken im Visual-Mode behält die Auswahl bei
vnoremap < <gv
vnoremap > >gv

" Halbe Seite scrollen und Cursor zentriert halten
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" ============================================================================
" AUTOCOMMANDS
" ============================================================================
augroup vim_config_autocmds
    autocmd!
    " Letzte Cursor-Position beim Öffnen einer Datei wiederherstellen
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") && &ft !~# 'commit' |
        \   exe "normal! g`\"" |
        \ endif

    " Splits automatisch anpassen, wenn das Terminal-Fenster skaliert wird
    autocmd VimResized * wincmd =
augroup END
