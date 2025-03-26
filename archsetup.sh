#!/bin/bash

EMAIL=$1

getemail() {
    if [ -z "$EMAIL" ]; then
        read -p "Please enter your email address: " EMAIL
    fi
}

getemail

yay -S visual-studio-code-bin
ssh-keygen -t ed25519 -C "$EMAIL"
git config --global user.email "$EMAIL"
git config --global user.name "Jesse"


yay -S github-cli
gh auth login
yay -S brave firefox
yay -S discord
