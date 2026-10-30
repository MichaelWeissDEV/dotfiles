# Legacy inventory for external scripts. Runtime packages use modules.d instead.
# Canonical package dependencies: packaging/arch/packages.json and package PKGBUILDs.
CONFIG_DIRS=(
    foot fuzzel ghostty gtk-3.0 gtk-4.0 hypr kitty libfm
    nvim pcmanfm tmux vim wallpaper waybar yazi zsh
)

PACMAN_PACKAGES=(
    hyprland hyprpaper hyprlock hypridle waybar fuzzel
    xdg-desktop-portal-hyprland wl-clipboard grim slurp satty
    brightnessctl power-profiles-daemon
    pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber
    gst-plugin-pipewire libpulse networkmanager bluez bluez-utils
    ghostty kitty foot zsh tmux
    neovim vim git fzf zoxide ripgrep fd jq wget man-db man-pages
    yazi pcmanfm firefox ttf-jetbrains-mono-nerd noto-fonts
)
