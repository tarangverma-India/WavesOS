

#!/bin/bash
# Script to set up user configurations
# This runs after user creation

USER_HOME="/home/$1"
cp -r /etc/skel/.config "$USER_HOME/"
cp /etc/skel/.bashrc "$USER_HOME/"
cp /etc/skel/.zshrc "$USER_HOME/"
chown -R "$1:$1" "$USER_HOME"
