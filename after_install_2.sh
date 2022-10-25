#!/bin/bash

# install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# stow configs
rm ~/.zshrc
cd ~/.dotfiles
stow nvim tmux zsh i3 i3status alacritty

# install vim-plugged
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install neovim plugins
# error output needs to redirected as there are plenty errors
# after running neovim's config without plugins installed
nvim --headless +PlugInstall +qa &>/dev/null

printf "\n\nRemember to set your font to Hack Nerd Font in terminal emulator.\n\n	You need to login again\n\n"
