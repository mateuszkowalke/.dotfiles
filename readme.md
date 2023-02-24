# Config and after install scripts for pop os with neovim as main editor

### Install

After installing fresh pop os or ubuntu, first run:

```sh
sudo apt update && sudo apt upgrade -y
```

Then run after_install scripts in order and provide required input when prompted.

Remember to set appropriate font in your terminal emulator.

For ubuntu you might want to install shell extensions and pop os shell (note: use jammy_master branch).

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
