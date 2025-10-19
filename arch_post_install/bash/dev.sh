#!/usr/bin/env bash

pkgs = (
	"nodejs"
	"npm"
	"typescript"
	"vscodium-bin"
	"tmux"
)

for pkg in "${pkgs[@]}"; do
	yay -S "$pkg" --noconfirm
done
