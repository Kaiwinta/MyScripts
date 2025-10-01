##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## setup_github
##

EMAIL=""

getemail () {
    echo "Enter your email address:"
    read -r EMAIL
    if [[ -z "$EMAIL" ]]; then
        echo "Email cannot be empty. Please try again."
        getemail
    fi
}

getusername () {
    echo "Enter your github username:"
    read -r USERNAME
    if [[ -z "$USERNAME" ]]; then
        echo "Username cannot be empty. Please try again."
        getusername
    fi
}

setup_github () {
    echo "Do you want to setup github ssh?"
    read -p "y/n: " GITHUB_SSH
    if [ "$GITHUB_SSH" == "y" ]; then
        echo "Configurating github"
        getemail
        getusername
        ssh-keygen -t ed25519 -C "$EMAIL"
        git config --global user.email "$EMAIL"
        git config --global user.name "$USERNAME"
        installIfNeeded github-cli
        gh auth login
    fi
}
