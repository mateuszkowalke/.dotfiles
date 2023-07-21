#!/bin/bash

set -e

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
sudo mv Hack.zip /usr/share/fonts
sudo unzip /usr/share/fonts/Hack.zip -d /usr/share/fonts
sudo rm /usr/share/fonts/Hack.zip

wget https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/wezterm-20230712-072601-f4abf8fd.Ubuntu20.04.deb
sudo apt-get -y install ./wezterm-20230712-072601-f4abf8fd.Ubuntu20.04.deb
rm -rf wezterm-20230712-072601-f4abf8fd.Ubuntu20.04.deb
