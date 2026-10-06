##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## setup_hyprland_config
##

#!/bin/bash

# This will copy the config as a link so that each update in the config can be applied to the system and sent to github 
setup_hyprland_config() {
	cp -lf config/hyprland.lua "/home/$USER/.config/hypr/hyprland.lua"
}