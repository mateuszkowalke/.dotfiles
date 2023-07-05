#!/bin/bash

set -e

# create a folder for applications installed as appimages
mkdir -p ~/Applications

# make sure curl is installed
sudo apt-get -y install curl

# add brave's repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# add pgAdmin repo
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'

# update and install necessary packages
# ripgrep is needed for nvim telescope to work properly and used as nvim's grepprg
# fuse and libfuse2 are needed to support AppImages
sudo apt-get update
sudo apt-get -y install apt-transport-https i3-wm i3status i3lock \
    git make libssl-dev curl wget zsh dmenu build-essential xautolock \
    stow fzf pip tmux lm-sensors brave-browser liferea pgadmin4 ripgrep \
    maim xclip xsel feh compton jq wireshark nmap gnome-clocks solaar \
    fuse libfuse2 gimp

# add user to wireshark group, so that it doesn't need to be run as root
sudo usermod -aG wireshark $USER

# install nvim
./nvim_install.sh

# install wezterm
./wezterm_install.sh

# git aliases
sh ./git_aliases.sh

# workspaces mod
./gnome_workspaces_mod.sh

# install rtx (asdf equivalent)
sudo curl https://rtx.pub/rtx-latest-linux-x64 -o /usr/local/bin/rtx
sudo chmod +x /usr/local/bin/rtx
/usr/local/bin/rtx activate zsh

# add core rtx tools
rtx use --global node@latest
rtx use --global python@latest
rtx use --global go@latest
rtx use --global rust@latest

# clone notes
git clone git@github.com:mateuszkowalke/notes.git ~/Notes

# create a directory for projects
mkdir -p ~/Projects

# install docker
sh ./docker_install.sh

# install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "\n\n	You need to login again\n\n"
