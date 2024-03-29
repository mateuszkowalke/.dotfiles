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

# add nextcloud client's repo
sudo add-apt-repository ppa:nextcloud-devs/client -y

# add obs studio repo
sudo add-apt-repository ppa:obsproject/obs-studio

# update and install necessary packages
# ripgrep is needed for nvim telescope to work properly and used as nvim's grepprg
# fuse and libfuse2 are needed to support AppImages
sudo apt-get update
sudo apt-get -y install apt-transport-https i3-wm i3status i3lock \
    git make libssl-dev curl wget zsh rofi build-essential xautolock \
    stow fzf pip tmux lm-sensors brave-browser liferea pgadmin4 ripgrep \
    maim xclip xsel feh compton jq wireshark nmap gnome-clocks solaar \
    fuse libfuse2 gimp valgrind gdbserver htop brightnessctl obs-studio \
    nextcloud-desktop moreutils

# add user to wireshark group, so that it doesn't need to be run as root
sudo usermod -aG wireshark $USER

# install nvim
./nvim_install.sh

# install wezterm
./wezterm_install.sh

# install obsidian
./obsidian_install.sh

# install tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# git aliases
sh ./git_aliases.sh

# workspaces mod
./gnome_workspaces_mod.sh

# install mise (asdf equivalent)
curl https://mise.run | sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# add platformio
wget -O get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
python3 get-platformio.py
rm get-platformio.py

# clone notes and scripts
# bear in mind the notes are moved to nextcloud synced folder too
git clone git@github.com:mateuszkowalke/notes.git
git clone git@github.com:mateuszkowalke/scripts.git

# install scripts
mkdir -p ~/.local/bin
~/Scripts/install.sh

# register git aliases
./git_aliases.sh

# create a directory for projects
mkdir -p ~/projects

# install docker
sh ./docker_install.sh

# install starship (prompt)
# this may fail on next fresh install
curl -sS https://starship.rs/install.sh | sh

# install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf "\n\n	You need to login again\n\n"
