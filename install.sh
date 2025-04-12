#!/bin/bash

SCRIPT_FULL_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_FULL_PATH")"
SCRIPT_PATH=usefull_scripts
EXECUTABLES_PATH=executables

add_alias() {
    file="$1"
    alias_name="$2"
    alias_command="$3"
    
    if grep -q "alias $alias_name=" "$file"; then
        echo -e "\033[0;33mAlias '$alias_name' already exists\033[0;0m in $file"
    else
        echo -n "Adding alias '$alias_name' to $file"
        echo "alias $alias_name=\"$alias_command\"" >> "$file"
        echo -e "\rAdding alias '$alias_name' to $file\033[35;m done\033[0m\n"
    fi
}

install_colors() {
    file="$1"

    if grep -q "# Color functions" "$file"; then
        echo "Colors already installed in $file"
    else
        echo "# Color functions" >> "$file"
        echo 'RED() { echo -ne "\033[0;31m"; }' >> "$file"
        echo 'GREEN() { echo -ne "\033[0;32m"; }' >> "$file"
        echo 'YELLOW() { echo -ne "\033[0;33m"; }' >> "$file"
        echo 'BLUE() { echo -ne "\033[0;34m"; }' >> "$file"
        echo 'MAGENTA() { echo -ne "\033[0;35m"; }' >> "$file"
        echo 'CYAN() { echo -ne "\033[0;36m"; }' >> "$file"
        echo 'WHITE() { echo -ne "\033[0;37m"; }' >> "$file"
        echo 'BOLD_RED() { echo -ne "\033[1;31m"; }' >> "$file"
        echo 'BOLD_GREEN() { echo -ne "\033[1;32m"; }' >> "$file"
        echo 'BOLD_YELLOW() { echo -ne "\033[1;33m"; }' >> "$file"
        echo 'BOLD_BLUE() { echo -ne "\033[1;34m"; }' >> "$file"
        echo 'BOLD_MAGENTA() { echo -ne "\033[1;35m"; }' >> "$file"
        echo 'BOLD_CYAN() { echo -ne "\033[1;36m"; }' >> "$file"
        echo 'BOLD_WHITE() { echo -ne "\033[1;37m"; }' >> "$file"
        echo 'RESET() { echo -ne "\033[0m"; }' >> "$file"
    fi
}

echo -ne "\033[0;34mInstalling colors...\033[0m"
install_colors ~/.bashrc
install_colors ~/.zshrc
echo -ne "\r\033[0;34mInstalling colors...\033[0m\033[35;m done\033[0m\n"

echo -ne "\033[0;34mSetting up pushnorme\033[0m\n"
add_alias ~/.bashrc push "$SCRIPT_DIR/$SCRIPT_PATH/pushnorme.sh"
add_alias ~/.zshrc push "$SCRIPT_DIR/$SCRIPT_PATH/pushnorme.sh"

echo -ne "\033[0;34mSetting up epitech-coding-style-checker\033[0m\n"
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

echo "Setting up Lambdananas"
add_alias ~/.bashrc lambda "$SCRIPT_DIR/$EXECUTABLES_PATH/lambdananas"
add_alias ~/.zshrc lambda "$SCRIPT_DIR/$EXECUTABLES_PATH/lambdananas"

echo "Setting up clang-format alias"
add_alias ~/.bashrc c-format "find . -name '*.cpp' -exec clang-format -i {} +"
add_alias ~/.zshrc c-format "find . -name '*.cpp' -exec clang-format -i {} +"


echo "Setting up Epitech environment"
if [[ ! -d ~/.epitech_tester_installer ]]; then
    echo "Cloning epitech_tester"
    git clone git@github.com:floriangolling/epitech_tester.git ~/.epitech_tester_installer
    chmod 777 ~/.epitech_tester_installer/setup.sh
    sudo ~/.epitech_tester_installer/setup.sh
fi