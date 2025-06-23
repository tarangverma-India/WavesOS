#!/bin/bash
# Smart configuration copying for WavesOS

PROFILE_DIR="waveos-profile"
AIROOTFS="$PROFILE_DIR/airootfs"

echo "Copying WavesOS configurations..."

# Create directories
mkdir -p "$AIROOTFS/etc/skel"
mkdir -p "$AIROOTFS/root"
mkdir -p "$AIROOTFS/usr/share/icons/waveos"
mkdir -p "$AIROOTFS/usr/share/themes/waveos"

# Copy .config directory
if [ -d ~/.config ]; then
    echo "Copying ~/.config..."
    cp -r ~/.config "$AIROOTFS/etc/skel/"
    cp -r ~/.config "$AIROOTFS/root/"
fi

# Copy .icons directory
if [ -d ~/.icons ]; then
    echo "Copying ~/.icons..."
    cp -r ~/.icons "$AIROOTFS/etc/skel/"
    cp -r ~/.icons "$AIROOTFS/root/"
    # Also copy to system-wide location
    cp -r ~/.icons/* "$AIROOTFS/usr/share/icons/waveos/"
fi

# Copy other important dotfiles
for file in .bashrc .zshrc .profile .vimrc .tmux.conf .gitconfig .xinitrc .xprofile; do
    if [ -f ~/$file ]; then
        echo "Copying $file..."
        cp ~/$file "$AIROOTFS/etc/skel/"
        cp ~/$file "$AIROOTFS/root/"
    fi
done

# Copy themes if they exist
if [ -d ~/.themes ]; then
    echo "Copying ~/.themes..."
    cp -r ~/.themes "$AIROOTFS/etc/skel/"
    cp -r ~/.themes/* "$AIROOTFS/usr/share/themes/waveos/"
fi

# Copy fonts if they exist
if [ -d ~/.fonts ] || [ -d ~/.local/share/fonts ]; then
    mkdir -p "$AIROOTFS/usr/share/fonts/waveos"
    [ -d ~/.fonts ] && cp -r ~/.fonts/* "$AIROOTFS/usr/share/fonts/waveos/"
    [ -d ~/.local/share/fonts ] && cp -r ~/.local/share/fonts/* "$AIROOTFS/usr/share/fonts/waveos/"
fi

echo "Configuration copying completed!"
