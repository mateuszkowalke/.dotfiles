#!/bin/bash

set -e

wget https://github.com/wez/wezterm/releases/download/20230408-112425-69ae8472/WezTerm-20230408-112425-69ae8472-Ubuntu20.04.AppImage
mv WezTerm-20230408-112425-69ae8472-Ubuntu20.04.AppImage ~/Applications/wezterm
chmod +x ~/Applications/wezterm
rm -rf WezTerm-20230408-112425-69ae8472-Ubuntu20.04.AppImage
