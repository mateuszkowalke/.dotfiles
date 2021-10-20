#!/bin/bash

if cat /etc/os-release | grep -i "ubuntu" > /dev/null; then
    echo "detected ubuntu system"
    sudo apt update
    sudo apt install stow i3 i3status tmux
elif cat /etc/os-release | grep -i "arch" > /dev/null; then
    echo "detected arch system"
    sudo pacman -S stow i3 i3status tmux
fi
