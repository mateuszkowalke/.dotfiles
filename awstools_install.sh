#!/bin/bash

set -e

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws
rm awscliv2.zip

curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo apt-get install ./session-manager-plugin.deb
rm session-manager-plugin.deb

curl "https://asset.noovolari.com/latest/Leapp_0.18.1_amd64.deb" -o "Leapp_0.18.1_amd64.deb"
sudo apt-get install ./Leapp_0.18.1_amd64.deb
rm Leapp_0.18.1_amd64.deb

npm install -g @noovolari/leapp-cli

curl -L "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -o "sam-cli.zip"
unzip sam-cli.zip -d sam-installation
sudo ./sam-installation/install
rm -rf sam-installation
rm sam-cli.zip
