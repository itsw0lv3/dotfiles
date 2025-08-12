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
    arch_utils.install_pkgs(hyprland_pkgs)

    confirm_amd = input("Install amd extra pkgs? Y/N: ")
    if confirm_amd.upper() == "Y":
        arch_utils.install_pkgs(amd_pkgs)



