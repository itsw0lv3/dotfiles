import subprocess
from datetime import datetime


def screen_shot(mode: str):
    if mode == "region":
        subprocess.Popen(["main -s | xclip -selection clipboard -t image/png"])
    else:
        now = datetime.now()
        name = now.strftime("%d%m%Y-%H%M%S")
        subprocess.Popen([
            "main",
            "-s",
            f"/home/w0lv3/Pictures/Screenshots/{name}.png"
        ])


def get_power_profile():
    result = subprocess.run(
            ["powerprofilesctl", "get"],
            capture_output=True,
            text=True
    )
    return result.stdout.strip()


def toggle_power_profile():
    opts = ["power-saver", "balanced", "performance"]
    curr_profile = get_power_profile()
    idx_pos = opts.index(curr_profile)

    if idx_pos >= len(opts)-1:
        idx_pos = 0
    else:
        idx_pos += 1

    subprocess.run(f"powerprofilesctl set {opts[idx_pos]}", shell=True)


