#!/bin/bash

SCRIPT_FULL_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_FULL_PATH")"
SCRIPT_PATH=usefull_scripts

echo $PATH
add_alias() {
    file="$1"
    alias_name="$2"
    alias_command="$3"
    
    if grep -q "alias $alias_name=" "$file"; then
        echo "Alias '$alias_name' already exists in $file"
    else
        echo "alias $alias_name=\"$alias_command\"" >> "$file"
        echo "Added alias '$alias_name' to $file"
    fi
}

echo "Setting up pushnorme"
add_alias ~/.bashrc push "$SCRIPT_DIR/$SCRIPT_PATH/pushnorme.sh"
add_alias ~/.zshrc push "$SCRIPT_DIR/$SCRIPT_PATH/pushnorme.sh"

echo "Setting up epitech-coding-style-checker"
if [[ ! -d ~/.epitech-coding-style-checker ]]; then
    echo "Cloning epitech-coding-style-checker"
    git clone git@github.com:Epitech/coding-style-checker.git ~/.epitech-coding-style-checker
else
    echo "epitech-coding-style-checker already exists"
fi
add_alias ~/.bashrc style "~/.epitech-coding-style-checker/coding-style.sh . ."
add_alias ~/.zshrc style "~/.epitech-coding-style-checker/coding-style.sh . . ; cat coding-style-reports.log"

echo "Setting up init_project"
add_alias ~/.bashrc init_project "$SCRIPT_DIR/$SCRIPT_PATH/init_project.sh"
add_alias ~/.zshrc init_project "$SCRIPT_DIR/$SCRIPT_PATH/init_project.sh"
