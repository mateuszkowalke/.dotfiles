#!/bin/zsh

set -e

# install lazygit
go install github.com/jesseduffield/lazygit@latest

# install yarn - needed for some neovim plugins
npm install --global yarn

# install neovim plugins
# error output needs to redirected as there are plenty errors
# after running neovim's config without plugins installed
nvim --headless +PackerSync +qa &>/dev/null

printf "\n\nRemember to set your font to Hack Nerd Font in terminal emulator.\n\n	You need to login again\n\n"
