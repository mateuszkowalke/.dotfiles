#!/bin/bash

# make sure curl is installed
sudo apt-get -y install curl

# add brave's repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# add pgAdmin repo
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt-get update'

# update and install necessary packages
# ripgrep is needed for nvim telescope to work properly and used as nvim's grepprg
sudo apt-get update
sudo apt-get -y install apt-transport-https build-essential zsh i3-wm i3status dmenu \
    git make libssl-dev curl wget neovim python3-neovim \
    stow fzf pip tmux lm-sensors brave-browser liferea pgadmin4 ripgrep \
    maim xclip xsel feh compton jq wireshark nmap gnome-clocks solaar

# alacritty's dependencies
sudo apt-get -y install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev

# add user to wireshark group, so that it doesn't need to be run as root
sudo usermod -aG wireshark $USER

# git aliases
sh ./git_aliases.sh

# install patched font
./font_install.sh

# workspaces mod
./gnome_workspaces_mod.sh

# clone asdf repo - rest of configurations provided by oh-my-zsh plugin
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# tmux plugin manager install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# tmuxifier install
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

# clone notes
git clone git@github.com:mateuszkowalke/notes.git ~/Notes

# create a directory for projects
mkdir -p ~/Projects

# install docker
sh ./docker_install.sh

# install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "\n\n	You need to login again\n\n"
