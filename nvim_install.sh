#!/bin/bash

wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb.sha256sum
sha256sum nvim-linux64.deb

if ($(sha256sum -c nvim-linux64.deb.sha256sum) != "nvim-linux64.deb: OK")
then
    rm -rf nvim-linux*
    printf "\n\n    Checksum for neovim not matching - exiting!\n\n"
    exit 1
fi

sudo apt install ./nvim-linux64.deb
rm -rf nvim-linux64.deb
