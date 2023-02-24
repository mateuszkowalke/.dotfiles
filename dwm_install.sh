#!/bin/bash

# installs dwm, dmenu and st

# install dependencies
sudo apt update
sudo apt install -y build-essential libx11-dev libxinerama-dev sharutils suckless-tools libxft-dev stterm compton feh

cd ~/Projects
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st

cd dwm
make
sudo make install

cd ../dmenu
make
sudo make install

cd ../st
make
sudo make install

sudo cp ~/.dotfiles/dwm.desktop /usr/share/xsessions
