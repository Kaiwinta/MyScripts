#!/bin/bash

# Move to workspace 2 silently and launch kitty (terminal)
hyprctl dispatch movetoworkspacesilent 2
sleep 0.2
kitty &

# Move to workspace 3 silently and launch VS Code
hyprctl dispatch movetoworkspacesilent 3
sleep 0.2
code &
