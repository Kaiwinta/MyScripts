##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## install_if_needed
##

## This script checks if a package is installed using yay and installs it if not.
installIfNeeded() {
    PACKAGE=$1
    yay -Qi $PACKAGE &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Installing $PACKAGE"
        yay -S $PACKAGE
    else
        echo "$PACKAGE is already installed"
    fi
}
