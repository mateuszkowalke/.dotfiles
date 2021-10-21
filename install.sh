#!/bin/bash

echo "Please note that this script removes all configs for all packages."
echo "If you're not sure if you want to do this - don't."
read -p "Do you want to continue? (y/n) " continue

if [ $continue == 'n' ]; then
    exit 0
fi

if cat /etc/os-release | grep -i "ubuntu" > /dev/null; then
    echo "detected ubuntu system"
    sudo apt update
    sudo apt install stow i3-wm i3status tmux
elif cat /etc/os-release | grep -i "arch" > /dev/null; then
    echo "detected arch system"
    sudo pacman -S stow i3-wm i3status tmux
    rm -rf ~/.config/i3
    rm -rf ~/.config/i3status
fi
