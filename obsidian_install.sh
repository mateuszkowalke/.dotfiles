#!/bin/bash

set -e

wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.3/obsidian_1.5.3_amd64.deb
sudo apt-get -y install ./obsidian_1.5.3_amd64.deb
rm -rf obsidian_1.5.3_amd64.deb

