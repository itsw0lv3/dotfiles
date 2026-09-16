import subprocess
from libqtile import bar, widget
from libqtile.config import Screen

from utils import toggle_power_profile, get_power_profile


def get_num_monitors():
    try:
        out = subprocess.check_output(["xrandr", "-q"]).decode()
        return out.count(" connected")
    except Exception:
        return 1


class BarBuilder:
    def __init__(self, show_systray=False):
        self.show_systray = show_systray

    def build(self):
        widgets = [
                widget.CurrentLayout(),
                widget.GroupBox(highlight_method="line"),
                widget.TaskList(max_title_width=240),
                widget.Chord(
                    chords_colors={"launch": ("#ff0000", "#ffffff")},
                    name_transform=lambda name: name.upper(),
                ),
                widget.Battery(),
                widget.TextBox("|"),
                widget.GenPollText(
                    func=get_power_profile,
                    update_interval=1,
                    mouse_callbacks={
                        "Button1": toggle_power_profile
                        },
                ),
                widget.TextBox("|"),
        ]
        if self.show_systray:
            widgets.append(widget.Systray())

        widgets.append(widget.TextBox("|"))
        widgets.append(widget.Clock(format="%Y-%m-%d %a %I:%M %p"))
        widgets.append(widget.QuickExit())

        return bar.Bar(widgets, 32)


num_monitors = get_num_monitors()

if num_monitors >= 2:
    screens = [
            Screen(top=BarBuilder(show_systray=True).build()),
            Screen(top=BarBuilder().build()),
    ]
else:
    screens = [
            Screen(top=BarBuilder(show_systray=True).build()),
    ]

