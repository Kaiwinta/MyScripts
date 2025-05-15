#!/bin/bash

SCRIPT_FULL_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_FULL_PATH")"

source "$SCRIPT_DIR/utils/install_if_needed.sh"

setup_arch() {
    echo "Installing git"
    installIfNeeded git

    echo "Installing IDE"
    installIfNeeded visual-studio-code-bin
    installIfNeeded rider

    echo "Installing Browser"
    installIfNeeded brave
    installIfNeeded firefox

    echo "Installing Discord"
    installIfNeeded discord

    echo "Installing Stack"
    installIfNeeded stack
    installIfNeeded ghc

    echo "Installing Docker"
    installIfNeeded docker daemon
    installIfNeeded docker-compose
    sudo systemctl enable docker
    sudo systemctl start docker
}
