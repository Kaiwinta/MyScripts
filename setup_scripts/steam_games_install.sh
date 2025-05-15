#!/bin/bash

source utils/install_if_needed.sh

gameList=("Hollow_Knight" "Helltaker" "Undertale" "Cs2" "Celeste" "Terraria" "Civilization V")

declare -A gameIdList=(
    ["Hollow_Knight"]=367520
    ["Helltaker"]=1289310
    ["Undertale"]=391540
    ["Cs2"]=730
    ["Celeste"]=504230
    ["Terraria"]=105600
    ["Civilization V"]=8930
)

installGamesScript="/tmp/steamcmd_script.txt"

generateSteamScript() {
    echo "$1" > "$installGamesScript"  # $1 is login line
    for game in "${gameList[@]}"; do
        read -p "Do you want to install $game? (y/n): " INSTALL
        if [ "$INSTALL" == "y" ]; then
            GAME_ID="${gameIdList[$game]}"
            if [ -n "$GAME_ID" ]; then
                echo "app_update $GAME_ID validate" >> "$installGamesScript"
            else
                echo "Game ID for $game not found"
            fi
        fi
    done
    echo "quit" >> "$installGamesScript"
}

setup_steam() {
    echo "Installing Steam components..."
    installIfNeeded steam
    installIfNeeded steamcmd

    read -p "Do you want to log in to Steam with your account? (required for paid games) (y/n): " LOGIN
    if [ "$LOGIN" == "y" ]; then
        read -p "Enter your Steam username: " STEAM_USERNAME
        generateSteamScript "login $STEAM_USERNAME"
    else
        echo "Using anonymous login. Only free games will be installable."
        generateSteamScript "login anonymous"
    fi

    echo "Starting game installation..."
    steamcmd +runscript "$installGamesScript"
    rm "$installGamesScript"
}
