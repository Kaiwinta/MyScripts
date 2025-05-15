##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## setup_epitech_scripts
##

setup_epitech_scripts() {     
    echo -ne "\033[0;34mSetting up epitech-coding-style-checker\033[0m\n"
    if [[ ! -d ~/.epitech-coding-style-checker ]]; then
        echo "Cloning epitech-coding-style-checker"
        git clone git@github.com:Epitech/coding-style-checker.git ~/.epitech-coding-style-checker
    else
        echo "epitech-coding-style-checker already exists"
    fi
    echo "Setting up Epitech environment"
    if [[ ! -d ~/.epitech_tester_installer ]]; then
        echo "Cloning epitech_tester"
        git clone git@github.com:floriangolling/epitech_tester.git ~/.epitech_tester_installer
        chmod 777 ~/.epitech_tester_installer/setup.sh
        sudo ~/.epitech_tester_installer/setup.sh
    else
        echo "epitech_tester already exists"
    fi
}