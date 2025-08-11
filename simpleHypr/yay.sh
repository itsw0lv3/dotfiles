#!/usr/bin/env bash

sudo pacman -S go

mkdir sources
cd sources
git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si
