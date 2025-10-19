#!/usr/bin/env bash

pkgs = (
	"gamemode"
	"gamescope"
	"steam"
	"heroic-games-launcher-bin"
	"protonup-qt"
	"protontricks"
	"winetricks"
)

for pkg in "${pkgs[@]}"; do
	yay -S "$pkg" --noconfirm
done
