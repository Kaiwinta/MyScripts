##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## setup_aliases
##

#!/bin/bash

SCRIPT_FULL_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_FULL_PATH")"

source "$SCRIPT_DIR/utils/add_alias.sh"

SCRIPT_PATH=scripts
TEMPLATES_PATH=Epitech-templates
EXECUTABLES_PATH=executables

setup_aliases() {
    echo -ne "\033[0;34mAdding alias for pushnorme\033[0m\n"
    add_alias ~/.bashrc push "$SCRIPT_DIR/$SCRIPT_PATH/pushnorme.sh"
    add_alias ~/.zshrc push "$SCRIPT_DIR/$SCRIPT_PATH/pushnorme.sh"

    if [[ -f ~/.epitech-coding-style-checker/coding-style.sh ]]; then
        echo -ne "\033[0;34mAdding alias for coding-style.sh\033[0m\n"
        add_alias ~/.bashrc style "~/.epitech-coding-style-checker/coding-style.sh . .; cat coding-style-reports.log"
        add_alias ~/.zshrc style "~/.epitech-coding-style-checker/coding-style.sh . . ; cat coding-style-reports.log"
    fi

    if [[ -f "$SCRIPT_DIR/$TEMPLATES_PATH/init_project.sh" ]]; then
        echo -ne "\033[0;34mAdding alias for init_project.sh\033[0m\n"
        add_alias ~/.bashrc init_project "$SCRIPT_DIR/$TEMPLATES_PATH/init_project.sh"
        add_alias ~/.zshrc init_project "$SCRIPT_DIR/$TEMPLATES_PATH/init_project.sh"
    fi

    echo "Adding alias for Lambdananas"
    add_alias ~/.bashrc lambda "$SCRIPT_DIR/$EXECUTABLES_PATH/lambdananas"
    add_alias ~/.zshrc lambda "$SCRIPT_DIR/$EXECUTABLES_PATH/lambdananas"

    echo "Adding alias for Wallpaper"
    add_alias ~/.bashrc wallpaper "$SCRIPT_DIR/$SCRIPT_PATH/HyDeWallpaper.sh"
    add_alias ~/.zshrc wallpaper "$SCRIPT_DIR/$SCRIPT_PATH/HyDeWallpaper.sh"

    echo "Adding alias for clang-format alias"
    add_alias ~/.bashrc c-format "find . -name '*.cpp' -exec clang-format -i {} +"
    add_alias ~/.zshrc c-format "find . -name '*.cpp' -exec clang-format -i {} +"

    echo "Adding alias for screenrecorder"
    add_alias ~/.bashrc screenrecorder "wf-recorder -f ~/Videos/recording-\$(date +%Y-%m-%d_%H-%M-%S).mp4"
    add_alias ~/.zshrc screenrecorder "wf-recorder -f ~/Videos/recording-\$(date +%Y-%m-%d_%H-%M-%S).mp4"

    echo "Adding alias for Epitech environment"
    if [[ ! -d ~/.epitech_tester_installer ]]; then
        echo "Cloning epitech_tester"
        git clone git@github.com:floriangolling/epitech_tester.git ~/.epitech_tester_installer
        chmod 777 ~/.epitech_tester_installer/setup.sh
        sudo ~/.epitech_tester_installer/setup.sh
    fi
}