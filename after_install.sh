#!/bin/bash

# add brave's repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# add pgAdmin repo
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

# update and install necessary packages
# ripgrep is needed for nvim telescope to work properly
sudo apt update
sudo apt install -y apt-transport-https build-essential zsh i3-wm i3status dmenu \
    stow fzf pip tmux lm-sensors brave-browser pgadmin4 ripgrep maim xclip feh compton

# install pyenv's dependencies
sudo apt-get install git python-pip make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl python3-pip libffi-dev \
    taskwarrior
pip3 install virtualenvwrapper

# git aliases
sh ./git_aliases.sh

# install hack nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
mkdir -p ~/.local/share/fonts/NerdFonts
unzip Hack.zip -d ~/.local/share/fonts/NerdFonts
rm -rf Hack.zip

# workspaces mod
./gnome_workspaces_mod.sh

# install neovim
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
rm -rf nvim-linux*
pip3 install pynvim

# install pyenv
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper

# install pyenv virtualenv pluign and configure it to activate virtualenvs when in directory
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# install nvm and node
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install alacritty - depends on rust already being on the system
cargo install alacritty

# install yarn - needed for some neovim plugins
npm install --global yarn

# create a directory for projects
mkdir -p ~/Projects

# install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install docker
sh ./docker_install.sh
