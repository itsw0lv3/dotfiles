#!/usr/bin/env bash

echo Basic Arch Hyprland... I mean basic bruh
echo ps.... I hope you got that yay installed....

pkgs=(
hyprland
hyprland
hypridle
hyprpaper
hyprlock
waybar
pavucontrol
dunst
brightnessctl
waytrogen
wl-clipboard
wl-clip-persist 
ttf-dejavu
ttf-dejavu-nerd
ttf-font-awesome
rofi-wayland
qt5-wayland
qt6-wayland
xdg-desktop-portal-hyprland
btop
wlogout
hyprshot
uwsm
)


yay -S "${pkgs[*]}"
