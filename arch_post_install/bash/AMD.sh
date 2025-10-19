#!/usr/bin/env bash

pkgs = (
	"lib32-mesa"
	"vulkan-radeon"
	"lib32-vulkan-radeon"
	"vulkan-icd-loader"
	"lib32-vulkan-icd-loader"
)

for pkg in "${pkgs[@]}"; do
	yay -S "$pkg" --noconfirm
done
