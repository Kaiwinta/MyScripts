#!/bin/bash

##
## EPITECH PROJECT, 2025
## MyScripts
## File description:
## setup_grub_dual_boots
##

sudo pacman -S os-prober

sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub || echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub

sudo os-prober

sudo grub-mkconfig -o /boot/grub/grub.cfg
