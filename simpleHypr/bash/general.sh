#!/usr/bin/env bash

pkgs=(
	"gimp"
	"inkscape"
	"mpv"
	"vlc"
	"obs-studio"
	"obsidian"
	"anki-bin"
	"fastfecth"
)

for pkg in "${pkgs[@]}"; do
	yay -S "$pkg" --noconfirm
done
