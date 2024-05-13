# Config and after install scripts for pop os with neovim as main editor
 
### Install
 
After installing fresh pop os or ubuntu, first run:
 
```sh
sudo apt update && sudo apt upgrade -y
```

Preferred method for proceeding is:
 - install git and clone this repo,
 - create ssh keys using `ssh_init.sh` script (keys are managed by ssh-agent then),
 - add keys to github,
 - remove and clone this repo again using ssh.

* if not setting up ssh keys, either comment out cloning of 'Notes' and 'Scripts' repos or do it using https.

Then run after_install scripts in order, provide required input when prompted and relogin after each step (on VMs it might be required to restart the machine between each step).
Important: allow non-root users for wireshark to capture packets upon installation - if you forget to do this run `sudo dpkg-reconfigure wireshark-common` to reconfigure it after installation is complete.

Remember to set appropriate font in your terminal emulator, although for i3/alacritty combination it's already configured.

For ubuntu you might want to install shell extensions and pop os shell (note: use jammy_master branch).

### Wallpapers in i3

Setting wallpapers in i3 is done by set_wallpaper.sh script from Scripts repo. It expects properly named wallpaper files in ~/Pictures/wallpapers folder. Have a look at the script for details. Example files are:
 - wallpaper--2560x1440.jpg
 - wallpaper--primary.jpg

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

### AppImage apps don't work - "AppImages require FUSE to run" error

Install the required packages:

`sudo apt-get install fuse libfuse2`

Now, FUSE should be working. On some older distributions, you will have to run some additional configuration steps:

Make sure the FUSE kernel module is loaded:

`sudo modprobe -v fuse`

Then, add the required group (should be created by the install command, if this is the case, this call will fail), and add your own user account to this group:

`sudo addgroup fuse`
`sudo adduser $USER fuse`
