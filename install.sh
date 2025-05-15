#!/bin/bash

source ./utils/install_if_needed.sh
source ./utils/add_alias.sh
source ./setup_scripts/setup_epitech_scripts.sh
source ./setup_scripts/steam_games_install.sh
source ./setup_scripts/setup_epitech_repo.sh
source ./setup_scripts/setup_aliases.sh
source ./setup_scripts/setup_github.sh
source ./setup_scripts/setup_colors.sh
source ./setup_scripts/setup_arch.sh


SCRIPT_FULL_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_FULL_PATH")"
SCRIPT_PATH=usefull_scripts
TEMPLATES_PATH=Epitech-templates
EXECUTABLES_PATH=executables


read -p "Do you want to install all arch packages? (yes/no) " yn
case $yn in
    yes | Y | y | Yes | YES)
        echo "Installing all arch packages"
        setup_arch
        ;;
esac


read -p "Do you want to setup Github and SSH? (yes/no) " yn
case $yn in
    yes | Y | y | Yes | YES)
        echo "Setting up Github and SSH"
        setup_github
        ;;
esac


read -p "Do you want to clone Epitech repo? (yes/no) " yn
case $yn in
    yes | Y | y | Yes | YES)
        echo "Setting up Epitech repo"
        setup_epitech_repo
        ;;
esac


read -p "Do you want to setup colors functions? (yes/no) " yn
case $yn in
    yes | Y | y | Yes | YES)
        echo "Setting up colors functions"
        setup_colors
        ;;
esac


read -p "Do you want to install epitech Templates? (yes/no) " yn
case $yn in
    yes | Y | y | Yes | YES)
        echo "Cloning epitech-templates"
        git clone https://github.com/Kaiwinta/Epitech-templates.git Epitech-templates
        echo "Setting up init_project"
        add_alias ~/.bashrc init_project "$SCRIPT_DIR/$TEMPLATES_PATH/init_project.sh"
        add_alias ~/.zshrc init_project "$SCRIPT_DIR/$TEMPLATES_PATH/init_project.sh"
esac


read -p "Do you want to install epitech scripts (style checker/epitest)? (yes/no) " yn
case $yn in
    yes | Y | y | Yes | YES)
        echo "Setting up epitech scripts"
        setup_epitech_scripts
        ;;
esac

setup_aliases

read -p "Do you want to install steam and steam games? (yes/no) " yn
case $yn in
    yes | Y | y | Yes | YES)
        echo "Setting up Steam and games"
        setup_steam
        ;;
esac