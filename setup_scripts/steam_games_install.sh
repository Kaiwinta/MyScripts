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

declare -A freeGameList=(
    ["Cs2"]=1
)

installGamesScript="/tmp/steamcmd_script.txt"
installedGames=()

generateSteamScript() {
    LOGIN_LINE="$1"
    echo "$LOGIN_LINE" > "$installGamesScript"
    # If the login is anonymous, we can only install free games
    if [ "$LOGIN_LINE" == "login anonymous" ]; then
        gameList=("${!freeGameList[@]}")
    fi
    for game in "${gameList[@]}"; do
        read -p "Do you want to install $game? (y/n): " INSTALL
        if [ "$INSTALL" == "y" ]; then
            GAME_ID="${gameIdList[$game]}"
            if [ -n "$GAME_ID" ]; then
                installedGames+=("$game")
                echo "app_update $GAME_ID validate" >> "$installGamesScript"
            else
                echo "Game ID for $game not found"
            fi
        fi
    done
    echo "quit" >> "$installGamesScript"
}

add_desktop_files() {
    for game in "${installedGames[@]}"; do
        GAME_ID="${gameIdList[$game]}"
        if [ -n "$GAME_ID" ]; then
            echo "Creating desktop file for $game"
            DESKTOP_FILE="$HOME/.local/share/applications/$game.desktop"
            echo "[Desktop Entry]"              > "$DESKTOP_FILE"
            echo "Name=$game"                   >> "$DESKTOP_FILE"
            echo "Comment=Play $game on Steam"  >> "$DESKTOP_FILE"
            echo "Exec=steam steam://rungameid/$GAME_ID" >> "$DESKTOP_FILE"
            echo "Icon=steam_icon_$GAME_ID"      >> "$DESKTOP_FILE"
            echo "Terminal=false"               >> "$DESKTOP_FILE"
            echo "Type=Application"             >> "$DESKTOP_FILE"
            echo "Categories=Game;"             >> "$DESKTOP_FILE"
        else
            echo "Game ID for $game not found, skipping desktop file creation."
        fi
    done
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
    add_desktop_files
}
