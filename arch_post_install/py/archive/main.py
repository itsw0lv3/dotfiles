import os
import json
import subprocess


def get_user():
    user = subprocess.check_output("echo $USER", shell=True)
    return user.decode("utf-8").rstrip("\n")


def install_yay():
    user = get_user()
    check_yay = subprocess.check_output(
            "pacman -Q yay",
            shell=True
            )

    if check_yay != "":
        print("Yay already installed, skipping")
    else:
        os.system("sudo pacman -S go")
        os.system("mkdir ~/sources")
        os.chdir(f"/home/{user}/sources")
        os.system("git clone https://aur.archlinux.org/yay.git")
        os.chdir("yay")
        os.system("makepkg -si")
        print("Yay installed")


def install_pkgs(pkg_manager: str, pkgs: str, flag: str = ""):
    os.system(f"{pkg_manager} {pkgs} {flag}")


def omz_install():
    print("Installing OhMyZSH, please exit when install complete!")
    os.system('sh -c "$(curl -fsSl https://raw/githubusercontent.com/ohmyzsh/master/tools/install.sh)"')


def omz_plugin_install():
    os.system("git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting")
    os.system("git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions")
    os.system("git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z")
    os.system("cp ~/dotfiles/.zshrc ~/")


# add option for DE, WM etc
def put_default_dots(env: str):
    user = get_user()
    os.chdir(f"/home/{user}/")
    # Put usual dots
    os.system("cp -r dotfilesc/config/nvim ~/.config/")
    os.system("cp dotfiles/config/.zshrc ~/")
    os.system("cp dotfiles/config/.tmux.conf ~/")

    match env:
        case "KDE":
            os.system("cp -r dotfiles/config/konsole/* .local/share/konsole/")
        case "Hypr":
            os.system("cp -r dotfiles/kitty ~/.config/")
            os.system("cp -r dotfiles/hypr ~/.config/")
            os.system("cp -r dotfiles/waybar ~/.config/")
            os.system("cp -r dotfiles/rofi ~/.config/")
            os.system("cp -r dotfiles/waytrogen ~/.config/")


def user_form():
    user = get_user()
    wanted_pkgs = []
    user_confirmed = False
    with open(f"/home/{user}/dotfiles/arch_post_install/py/arch_pkgs.json", "r") as f_pkgs:
        pkgs = json.load(f_pkgs)

    while not user_confirmed:
        for item in pkgs.keys():
            add_item = input(f"Do you want to install '{item}' pkgs? Y/N: ")
            if add_item.upper() == "Y":
                wanted_pkgs.append(item)
            else:
                continue

        print(wanted_pkgs)
        user_confirms = input("Are these the pkgs to install Y = yes, N = start again. Y/N: ")
        if user_confirms.upper() == "Y":
            user_confirmed = True
        else:
            os.system("clear")

    return wanted_pkgs


def create_pkgs_str(pkg_cat: str, pkgs_master: dict):
    return " ".join(pkgs_master[pkg_cat])


if __name__ == "__main__":
    user = get_user()
    # Change base path!
    BASE_PATH = f"/home/{user}"

    with open(f"{BASE_PATH}/dotfiles/arch_post_install/py/arch_pkgs.json", "r") as f_pkgs:
        pkgs = json.load(f_pkgs)

    # Maybe make this a function that will input the key from list?
    # Replace from test.py!
    # hyprland_pkgs = " ".join(pkgs["hyprland"])
    # fonts = " ".join(pkgs["font"])
    # amd_pkgs = " ".join(pkgs["amd_driver"])
    # dev_pkgs = " ".join(pkgs["dev"])
    # gaming_pkgs = " ".join(pkgs["gaming"])
    # general_pkgs = " ".join(pkgs["general"])
    # wine_pkgs = " ".join(pkgs["wine"])

    with open(f"{BASE_PATH}/dotfiles/arch_post_install/py/arch_pkgs.json", "r") as f_pkgs:
        pkgs = json.load(f_pkgs)

    pkgs_to_install = user_form()
    for item in pkgs_to_install:
        curr = create_pkgs_str(item, pkgs)
        install_pkgs("sudo dnf install ", curr)

    install_omz = input("Would you like to install oh-my-zsh? Y/n: ")
    if install_omz.upper() == "Y" or install_omz == "":
        os.system("yay -S zsh --noconfirm")
        omz_install()

    install_omz_plugs = input("Would you like to install oh-my-zsh plugins? Y/n: ")
    if install_omz_plugs.upper() == "Y" or install_omz_plugs == "":
        omz_plugin_install()
