#!/bin/bash

EMAIL=$1

installIfNeeded() { # function to check if a package is installed and install it if nots
    PACKAGE=$1
    yay -Qi $PACKAGE &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Installing $PACKAGE"
        yay -S $PACKAGE
    else
        echo "$PACKAGE is already installed"
    fi
}

getemail() { # function to get the email address from the user
    if [ -z "$EMAIL" ]; then
        read -p "Please enter your email address: " EMAIL
    fi
}

echo "Installing IDE"
installIfNeeded visual-studio-code-bin
installIfNeeded rider

echo "Do you want to setup github ssh?"
read -p "y/n: " GITHUB_SSH
if [ "$GITHUB_SSH" == "y" ]; then
    echo "Configurating github"
    getemail
    ssh-keygen -t ed25519 -C "$EMAIL"
    git config --global user.email "$EMAIL"
    git config --global user.name "Jesse"
    installIfNeeded github-cli
    gh auth login
fi

echo "Installing Browser"
installIfNeeded brave
installIfNeeded firefox

echo "Insatlling Discord"
installIfNeeded discord

echo "Installing Stack"
installIfNeeded stack
installIfNeeded ghc


echo "Installing Docker"
installIfNeeded docker daemon
installIfNeeded docker-compose
sudo systemctl enable docker
sudo systemctl start docker


gameList=("Hollow_Knight" "Helltaker" "Undertale" "Cs2")

declare -A gameIdList

gameIdList["Hollow_Knight"]=367520
gameIdList["Helltaker"]=1289310
gameIdList["Undertale"]=391540
gameIdList["Cs2"]=730

installGames() {
    for game in "${gameList[@]}"; do
        echo "Do you want to install $game?"
        read -p "y/n: " INSTALL
        if [ "$INSTALL" != "y" ]; then
            continue
        fi
        if [ -n "${gameIdList[$game]}" ]; then
            echo "Installing $game"
            steamcmd +force_install_dir "/home/$USER/.steam/steamapps/common/$game" +app_update "${gameIdList[$game]}" validate
        else
            echo "Game ID for $game not found"
        fi
    steamcmd +quit
    done
}

echo "Do you want to install steam?"
read -p "y/n: " STEAM
if [ "$STEAM" == "y" ]; then
    echo "Installing Steam"
    installIfNeeded steam 
    installIfNeeded steamcmd
    echo "Do you want to log in to Steam with your account? (required for paid games)"
    read -p "y/n: " LOGIN
    if [ "$LOGIN" == "y" ]; then
        read -p "Enter your Steam username: " STEAM_USERNAME
        read -sp "Enter your Steam password: " STEAM_PASSWORD
        echo
        steamcmd +login "$STEAM_USERNAME" "$STEAM_PASSWORD"
    else
        echo "Using anonymous login. Only free games will be installed."
    fi
    echo "Installing games"
    installGames
fi
