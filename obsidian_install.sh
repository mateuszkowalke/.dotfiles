#!/bin/bash

# need to manually update version in this script

VERSION=1.1.9

wget https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/obsidian_${VERSION}_amd64.deb

sudo apt install ./obsidian_${VERSION}_amd64.deb

rm -rf obsidian_${VERSION}_amd64.deb
