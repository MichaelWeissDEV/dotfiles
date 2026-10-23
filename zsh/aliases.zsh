# ============================================================================
# ~/.config/zsh/aliases.zsh - Aliases & Helper Functions (Zsh)
# ============================================================================

# Editor Aliases
alias nv='nvim'
alias v='vim'

# Dotfiles & System Management (~/git/dotfiles)
# Unified CLI program: adot / arch-dot / arch-dotfiles (linked in ~/.local/bin)
alias dotfiles='cd "$HOME/git/dotfiles"'
alias adot='"$HOME/git/dotfiles/scripts/adot"'
alias arch-dot='"$HOME/git/dotfiles/scripts/adot"'
alias arch-dotfiles='"$HOME/git/dotfiles/scripts/adot"'
alias cfg-update='"$HOME/git/dotfiles/scripts/adot" update'
alias cfg-links='"$HOME/git/dotfiles/scripts/adot" links'
alias cfg-subtrees='"$HOME/git/dotfiles/scripts/adot" subtrees'
alias cfg-wallpapers='"$HOME/git/dotfiles/scripts/adot" wallpapers'

# Wallpaper Switcher (Default + per-monitor overrides)
alias wp='wallpaper'

# Smart Directory Jumping (powered by zoxide: 'j' for jump, 'ji' for interactive fzf jump; 'z'/'zi' also supported)
if command -v zoxide >/dev/null 2>&1; then
    alias z='j'
    alias zi='ji'
fi

# Datei- & System-Aliases mit Farbunterstützung
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Tmux Schnellbefehle
alias tm='tmux new-session -A -s main'
alias tn='tmux new-session -s'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'

# ============================================================================
# FZF Funktionen (fznv / fzv)
# ============================================================================

# Datei interaktiv mit fzf suchen und anschließend in Neovim öffnen
function fznv() {
    local file
    file="$(fzf --height=40% --layout=reverse --border --prompt='nvim > ' "$@")" && [[ -n "$file" ]] && nvim "$file"
}

# Datei interaktiv mit fzf suchen und anschließend in Vim öffnen
function fzv() {
    local file
    file="$(fzf --height=40% --layout=reverse --border --prompt='vim > ' "$@")" && [[ -n "$file" ]] && vim "$file"
}

# ============================================================================
# Yazi Wrapper
# ============================================================================

# Yazi TUI-Dateimanager Wrapper (wechselt beim Beenden mit 'q' automatisch in den zuletzt gewählten Ordner)
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
