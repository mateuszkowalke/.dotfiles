#!/bin/bash

set -e

# installs docker engine and docker-compose following official instructions

printf "\n\nInstalling docker engine.\n\n"
sudo apt-get remove docker docker.io docker-doc docker-compose podman-docker containerd runc
sudo apt-get update
sudo apt-get -y install ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
printf "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

printf "\n\nAdding current user to docker group.\n\n"
sudo usermod -aG docker $USER

printf "\n\nEnabling docker services.\n\n"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

printf "\n\nLog in again for the group changes to take effect.\nAfter that you can run docker run hello-world to check your installation.\n"
