#!/bin/bash

# Color definitions
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
magenta="\e[1;35m"
cyan="\e[1;36m"
orange="\x1b[38;5;214m"
end="\e[0m"

# Gum banner or fallback ASCII
display_text() {
    gum style \
        --border rounded \
        --align center \
        --width 60 \
        --margin "1" \
        --padding "1" \
'
  __  __     _          __       ____
 / / / /__  (_)__  ___ / /____ _/ / /
/ /_/ / _ \/ / _ \(_-</ __/ _ `/ / / 
\____/_//_/_/_//_/___/\__/\_,_/_/_/  
                                     
'
}

# Message printing function
msg() {
    local actn=$1
    local msg=$2
    case $actn in
        act) printf "${green}=>${end} $msg\n" ;;
        ask) printf "${orange}??${end} $msg\n" ;;
        dn)  printf "${cyan}::${end} $msg\n\n" ;;
        att) printf "${yellow}!!${end} $msg\n" ;;
        nt)  printf "${blue}\$\$${end} $msg\n" ;;
        skp) printf "${magenta}[ SKIP ]${end} $msg\n" ;;
        err) printf "${red}>< Ohh sheet! an error..${end}\n   $msg\n"; sleep 1 ;;
        *)   printf "$msg\n" ;;
    esac
}

clear && display_text
printf " \n \n"

# Config directories to remove/backup
DOTFILES=(
    btop
    dunst
    fastfetch
    fish
    gtk-3.0
    gtk-4.0
    hypr
    kitty
    Kvantum
    nvim
    nwg-look
    qt5ct
    qt6ct
    rofi
    waybar
    xsettingsd
    yazi
)

BACKUP_DIR="$HOME/.config/hyprconf-$(date +%d-%m-%Y)"
WALLPAPER_DIR="$HOME/.config/hypr/Wallpaper"

msg nt "Uninstallation means, it will remove the dotfiles directories."
msg nt "Your sddm login manager will be untouched."
msg att "It will not remove the packages. Removing packages can cause system crash. You should remove them manually."

echo

# Ask for uninstallation confirmation
if ! gum confirm "Would you like to uninstall your config setup?" \
    --prompt.foreground "#e1a5cf" \
    --affirmative "Continue" \
    --selected.background "#e1a5cf" \
    --selected.foreground "#070415" \
    --negative "Skip"
then
    gum spin \
        --spinner dot \
        --spinner.foreground "#e1a5cf" \
        --title "Skipping the uninstallation process..." -- \
        sleep 2
    exit 0
fi

# Ask about wallpaper backup
msg ask "Would you like to backup your ${cyan}Wallpapers${end}?"
if gum confirm "Choose" \
    --prompt.foreground "#e1a5cf" \
    --affirmative "BackUp" \
    --selected.background "#e1a5cf" \
    --selected.foreground "#070415" \
    --negative "Remove"
then
    mkdir -p "$HOME/Wallpapers-Backup"
    mv "$WALLPAPER_DIR" "$HOME/Wallpapers-Backup/"
    msg dn "Wallpapers have been backed up into $HOME/Wallpapers-Backup directory"
fi

sleep 1 && clear

# Backup and remove dotfiles
msg act "Removing dotfiles and backing up..."

mkdir -p "$BACKUP_DIR" &> /dev/null

for item in "${DOTFILES[@]}"; do
    if [[ -d "$HOME/.config/$item" ]]; then
        mv "$HOME/.config/$item" "$BACKUP_DIR/" &> /dev/null
    fi
done

# Compress backup
CACHE_DIR="$HOME/.cache"
mkdir -p "$CACHE_DIR"

if [[ -d "$BACKUP_DIR/hypr" ]]; then
    ARCHIVE_NAME="$(basename "$BACKUP_DIR").tar.gz"
    tar -czf "$CACHE_DIR/$ARCHIVE_NAME" -C "$(dirname "$BACKUP_DIR")" "$(basename "$BACKUP_DIR")" &> /dev/null
    # msg dn "Dotfiles archived at $CACHE_DIR/$ARCHIVE_NAME"
fi

sleep 1 && clear

msg dn "Uninstallation complete! Need to reboot the system..."
msg ask "Would you like to reboot now?"
if gum confirm "Choose" \
    --prompt.foreground "#e1a5cf" \
    --affirmative "Reboot" \
    --selected.background "#e1a5cf" \
    --selected.foreground "#070415" \
    --negative "Skip"
then
    msg act "Rebooting the system in 3s" && sleep 3
    systemctl reboot --now
fi
