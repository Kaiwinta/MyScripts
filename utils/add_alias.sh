##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## add_alias
##

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
