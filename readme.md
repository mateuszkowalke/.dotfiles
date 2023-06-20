# Config and after install scripts for pop os with neovim as main editor

### Install

After installing fresh pop os or ubuntu, first run:

```sh
sudo apt update && sudo apt upgrade -y
```

Preferred method for proceeding is to install git and clone this repo (best to setup ssh keys first - otherwise notes won't be copied).
For setting up keys utilise `ssh_init.sh` script - this creates keys automatically managed by ssh-agent.

Then run after_install scripts in order and provide required input when prompted.
Important: allow non-root users for wireshark to capture packets.

Remember to set appropriate font in your terminal emulator.

For ubuntu you might want to install shell extensions and pop os shell (note: use jammy_master branch).

### Alacritty

Alacritty is build from source for now. It's set as default terminal emulator for i3.

### Tmux

This config uses prefix `Ctrl + a`, vim keybindings, 'vim-tmux-navigator' plugin and 'tmux-yank' plugin for copying into OS clipboard. 

To install tmux plugins run `prefix + I`.
To live reload tmux config run `prefix + r`.
To create vertical and horizontal splits use `pefix + |` and `prefix + -` respectively.
Thanks to 'vim-tmux-navigator' we can use `Ctrl + hjkl` to navigate both tmux panes and vim/neovim windows.
Keybindings for copying in copy-mode are `Ctrl + c` and `y`.

This config provides also a way to save and restore sessions with:
 - `prefix + Ctrl-s` save
 - `prefix + Ctrl-r` restore
The sessions are also automatically saved every 15 mins.

To rename windows use `prefix + ,`.
To rename sessions use `prefix + $`.

### App list (not exactly development related):

 - brave: used as default browser
 - liferea: rss and podcast viewer
 - gnome-clocks: for alarms
 - solaar: for logitech peripherals
