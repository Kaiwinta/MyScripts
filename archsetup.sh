#!/bin/bash

EMAIL=$1

getemail() {
    if [ -z "$EMAIL" ]; then
        read -p "Please enter your email address: " EMAIL
    fi
}

getemail

echo "Installing IDE"
yay -S visual-studio-code-bin
yay -S rider

echo "Configurating github"
ssh-keygen -t ed25519 -C "$EMAIL"
git config --global user.email "$EMAIL"
git config --global user.name "Jesse"
yay -S github-cli
gh auth login

echo "Installing Browser"
yay -S brave firefox

echo "Insatlling Discord"
yay -S discord

echo "Installing Stack"
yay -S stack
yay -S ghc

yay -S docker daemon
yay -S docker-compose
sudo systemctl enable docker
sudo systemctl start docker