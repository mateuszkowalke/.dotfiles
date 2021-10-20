#!/bin/bash

if cat /etc/os-release | grep -i "ubuntu" > /dev/null; then
    echo "detected ubuntu system"
    sudo apt update
    sudo apt install stow i3-wm i3status tmux
elif cat /etc/os-release | grep -i "arch" > /dev/null; then
    echo "detected arch system"
    sudo pacman -S stow i3-wm i3status tmux
    rm ~/.config/i3/config
    rm ~/.config/i3status/config
fi
