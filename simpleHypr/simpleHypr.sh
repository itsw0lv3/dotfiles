#!/usr/bin/env bash

# Add install yay!

pkgs=(
	"ly"
	"zsh"
	"btop"
	"git"
	"curl"
	"wget"
	"mono"
	"gcc"
	"go"
	"rustup"
	"neovim"
	"uwsm"
	"hyprland"
	"hypridle"
	"hyprlock"
	"hyprpaper"
	"hyprshot"
	"xdg-desktop-portal-hyprland"
	"qt5-wayland"
	"qt6-wayland"
	"wayland"
	"pavucontrol"
	"waybar"
	"wlogout"
	"wl-clipboard"
	"wl-clip-persist"
	"brightnessctl"
	"waytrogen"
	"kitty"
	"rofi-wayland"
	"power-profiles-daemon"
	"networkmanager"
	"openssh"
	"tar"
	"zip"
	"unzip"
	"gvfs"
	"thunar"
	"thunar-volman"
	"bluez"
	"bluetui"
	"man-db"
	"fd"
	"fzf"
	"the_silver_searcher"
	"nwg-look"
	"mousepad"
	"evince"
	"ristretto"
	"ttf-dejavu"
	"ttf-devaju-nerd"
	"otf-font-awesome"
	"zen-browser-bin"
)


for pkg in "${pkgs[@]}"; do
	yay -S "$pkg" --noconfirm
done

sudo systemctl enable ly
sudo systemctl enable NetworkManager

git clone https://github.com/itsw0lv3/dotfiles.git

cp -r dotfiles/hypr ~/.config
cp -r dotfiles/kitty ~/.config
cp -r dotfiles/waybar ~/.config
cp -r dotfiles/nvim ~/.config

rm -rf dotfiles
