#!/bin/bash

set -e

wget https://github.com/wez/wezterm/releases/download/20240127-113634-bbcac864/wezterm-20240127-113634-bbcac864.Ubuntu22.04.deb
sudo apt-get -y install ./wezterm-20240127-113634-bbcac864.Ubuntu22.04.deb
rm -rf wezterm-20240127-113634-bbcac864.Ubuntu22.04.deb

