#!/bin/bash

set -e

wget https://github.com/wez/wezterm/releases/download/20240128-202157-1e552d76/wezterm-20240128-202157-1e552d76.Ubuntu20.04.deb
sudo apt-get -y install ./wezterm-20240128-202157-1e552d76.Ubuntu20.04.deb
rm -rf wezterm-20240128-202157-1e552d76.Ubuntu20.04.deb

