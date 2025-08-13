import os
import subprocess


def get_user():
    user = subprocess.check_output("echo $USER", shell=True)
    return user.decode('utf-8').rstrip('\n')


def install_yay():
    os.system("sudo pacman -S go")
    os.system("mkdir ~/sources")
    os.chdir("~/sources")
    os.system("git clone https://aur.archlinux.org/yay.git")
    os.chdir("yay")
    os.system("makepkg -si")


def install_pkgs(pkgs: str, msg: str):
    query = input(f"{msg} Y/N: ")
    if query.upper() == "Y":
        os.system(f"yay -S {pkgs} --noconfirm")


def omz_install():
    os.system('sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')


def omz_plugin_install():
    os.system("git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting")
    os.system("git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions")
    os.system("git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z")
    os.system("cp ~/dotfiles/.zshrc ~/")


def put_dots():
    # Get user input laters
    user = get_user()
    os.chdir(f"/home/{user}/")
    os.system("cp -r dotfiles/nvim ~/.config/")
    os.system("cp -r dotfiles/kitty ~/.config/")
    os.system("cp -r dotfiles/hypr ~/.config/")
    os.system("cp -r dotfiles/waybar ~/.config/")
    os.system("cp -r dotfiles/rofi ~/.config/")
    os.system("cp -r dotfiles/waytrogen ~/.config/")
    os.system("cp -r dotfiles/ghostty ~/.config/")
    os.system("cp -r dotfiles/Wallpapers ~/Pictures/")
    os.system("cp dotfiles/.zshrc ~/")
    os.system("cp dotfiles/.tmux.conf ~/")
    os.system("source .zshrc")
