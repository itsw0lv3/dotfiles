import json
from main import user_form, install_pkgs, get_user, create_pkgs_str

user = get_user()
BASE_PATH = f"/home/{user}"

with open(f"{BASE_PATH}/dotfiles/arch_post_install/py/arch_pkgs.json", "r") as f_pkgs:
    pkgs = json.load(f_pkgs)

pkgs_to_install = user_form()
for item in pkgs_to_install:
    curr = create_pkgs_str(item, pkgs)
    install_pkgs("sudo dnf install ", curr)
