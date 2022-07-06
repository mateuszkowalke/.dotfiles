#!/bin/bash

# installs docker engine and docker-compose following official instructions

printf "Installing docker engine.\n\n"
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install ca-certificates url gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
printf "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

printf "Creating group docker and adding current user to it.\n\n"
sudo groupadd docker
sudo usermod -aG docker $USER

printf "Enabling docker services.\n\n"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

printf "Installing docker-compose.\n\n"
sudo apt update
sudo apt install docker-compose-plugin

printf "Log in again for the group changes to take effect.\nAfter that you can run docker run hello-world to check your installation.\n"
