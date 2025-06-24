#/bin/bash

IMAGEPATH=$1
if [ -z "$IMAGEPATH" ]; then
    echo "Usage: $0 <image_path>"
    exit 1
fi
if [ ! -f "$IMAGEPATH" ]; then
    echo "File not found: $IMAGEPATH"
    exit 1
fi
IMAGENAME=$(basename "$IMAGEPATH")

USERNAME=$(whoami)
if [ -z "$USERNAME" ]; then
    echo "Unable to determine username"
    exit 1
fi

if [ ! -d "/home/$USERNAME/.config/hyde/themes" ]; then
    echo "HyDe theme directory not found for user $USERNAME"
    exit 1
fi

oldIFS=$IFS
IFS=$'\n'

ThemesList=($(ls /home/$USERNAME/.config/hyde/themes/))

IFS=$oldIFS

retryTheme() {
    echo "Do you want to retry selecting a theme? (y/n)"
    read -r retry
    if [[ "$retry" =~ ^[Yy]$ ]]; then
        selectThemeIndex
    else
        echo "Exiting..."
        exit 1
    fi
}

selectThemeIndex() {
    echo "Available themes:"
    for i in "${!ThemesList[@]}"; do
        echo "$i: ${ThemesList[$i]}"
    done

    echo "Select a theme by number:"
    read -r themeIndex
    if ! [[ "$themeIndex" =~ ^[0-9]+$ ]] || [ "$themeIndex" -lt 0 ] ;then
        echo "Not a number > 0"
        retryTheme
    fi
    if [ "$themeIndex" -ge "${#ThemesList[@]}" ]; then
        echo "Them index out of range"
        retryTheme
    fi
}

selectThemeIndex
if [ -z "${ThemesList[$themeIndex]}" ]; then
    echo "Invalid theme index"
    retryTheme
fi
THEME="${ThemesList[$themeIndex]}"
if [ ! -d "/home/$USERNAME/.config/hyde/themes/$THEME" ]; then
    echo "Theme directory not found: /home/$USERNAME/.config/hyde/themes/$THEME"
    exit 1
fi

cp "$IMAGEPATH" "/home/$USERNAME/.config/hyde/themes/$THEME/$IMAGENAME"

echo "Image copied to theme directory: /home/$USERNAME/.config/hyde/themes/$THEME/$IMAGENAME"
