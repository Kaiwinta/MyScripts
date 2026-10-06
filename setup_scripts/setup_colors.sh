##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## setup_colors
##

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

setup_colors(){
    install_colors ~/.zshrc
    install_colors ~/.bashrc
}