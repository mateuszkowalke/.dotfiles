#!/bin/bash

set -e

wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage.sha256sum
sha256sum nvim.appimage

if [[ "$(sha256sum -c nvim.appimage.sha256sum)" != "nvim.appimage: OK" ]];
then
    rm -rf nvim.appimage*
    printf "\n\n    Checksum for neovim not matching - exiting!\n\n"
    exit 1
fi

mv nvim.appimage ~/Applications/nvim
chmod +x ~/Applications/nvim
rm -rf nvim.appimage*
