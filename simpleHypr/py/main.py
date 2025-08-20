import json
import arch_utils

user = arch_utils.get_user()
BASE_PATH = f"/home/{user}"

with open(f"{BASE_PATH}/dotfiles/simpleHypr/py/arch_pkgs.json", "r") as f_pkgs:
    pkgs = json.load(f_pkgs)


hyprland_pkgs = " ".join(pkgs["hyprland"])
amd_pkgs = " ".join(pkgs["amd_driver"])
dev_pkgs = " ".join(pkgs["dev"])
gaming_pkgs = " ".join(pkgs["gaming"])
general_pkgs = " ".join(pkgs["general"])
wine_pkgs = " ".join(pkgs["wine"])


if __name__ == "__main__":
    confirm_yay = input("Install yay? Y/N: ")
    if confirm_yay.upper() == "Y":
        print("Installing yay:")
        arch_utils.install_yay()

    print("Installing Hyprland")
    arch_utils.install_pkgs(hyprland_pkgs, "Install hyprland? I mean... ")
    arch_utils.install_pkgs(amd_pkgs, "Install amd extra pkgs?")
    arch_utils.install_pkgs(wine_pkgs, "Install wine extras?")
    arch_utils.install_pkgs(gaming_pkgs, "Install gaming stuff?")
    arch_utils.install_pkgs(dev_pkgs, "Install dev things?")
    arch_utils.install_pkgs(general_pkgs, "Install all the general stuff?")

    install_omz = input("Install Oh My Zsh? Y/N: ")
    if install_omz.upper() == "Y":
        arch_utils.omz_install()

    install_omz_plugins = input("Install OMZ Plugins? Y/N: ")
    if install_omz_plugins.upper() == "Y":
        arch_utils.omz_plugin_install()

    use_dotfiles = input("Use dotfiles? Y/N: ")
    if use_dotfiles.upper() == "Y":
        arch_utils.put_dots()

    # Update these things!
    print("Enabling tings")
    os.system("sudo systemctl enable ly")
    os.system("sudo systemctl enable NetworkManager")

    print("Creating themes and icons folders")
    user = get_user()
    os.chdir(f"/home/{user}")
    os.system("mkdir .themes .icons")

    


