#!/bin/bash

# stow configs
rm ~/.zshrc
cd ~/.dotfiles
stow nvim tmux zsh alacritty

# install vim-plugged
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install neovim plugins
nvim --headless +PlugInstall +qall

echo '\r\r	You need to reopen you terminal\r\r'
