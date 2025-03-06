#!/bin/bash


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
add_alias ~/.bashrc push "./{path}/pushnorme.sh"
add_alias ~/.zshrc push "./{path}/pushnorme.sh"

echo "Setting up epitech-coding-style-checker"
git clone git@github.com:Epitech/coding-style-checker.git ~/.epitech-coding-style-checker
add_alias ~/.bashrc style "~/.epitech-coding-style-checker/coding-style.sh . ."
add_alias ~/.zshrc style "~/.epitech-coding-style-checker/coding-style.sh . ."
