#!/bin/bash

set -e

wget https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb
sudo apt-get -y install ./wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb
rm -rf wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb
