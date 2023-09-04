import subprocess, os

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "kitty"
browser = "firefox"
runner = "rofi -show run"

keys = [
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "p", lazy.spawn(runner), desc="Launch runner"),
    Key([mod], "f", lazy.spawn(browser), desc="Launch browser"),

    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),

    Key([mod], "j", lazy.layout.next(), desc="Move window focus to next window"),
    Key([mod], "k", lazy.layout.previous(), desc="Move window focus to previous window"),

    Key([mod, "mod1"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "mod1"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "shift"], "h", lazy.layout.shrink_main(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_main(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.layout.reset(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),

    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ]
    )

from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# Gruvbox
from enum import Enum
class Color(Enum):
    ACTIVE_WINDOW   = "#f0833a"
    INACTIVE_WINDOW = "#808080"
    DARK0_HARD      = "#1d2021"
    DARK0           = "#282828"
    DARK0_SOFT      = "#32302f"
    DARK1           = "#3c3836"
    DARK2           = "#504945"
    DARK3           = "#665c54"
    DARK4           = "#7c6f64"
    DARK4_256       = "#7c6f64"
    GRAY_245        = "#928374"
    GRAY_244        = "#928374"
    LIGHT0_HARD     = "#f9f5d7"
    LIGHT0          = "#fbf1c7"
    LIGHT0_SOFT     = "#f2e5bc"
    LIGHT1          = "#ebdbb2"
    LIGHT2          = "#d5c4a1"
    LIGHT3          = "#bdae93"
    LIGHT4          = "#a89984"
    LIGHT4_256      = "#a89984"
    BRIGHT_RED      = "#fb4934"
    BRIGHT_GREEN    = "#b8bb26"
    BRIGHT_YELLOW   = "#fabd2f"
    BRIGHT_BLUE     = "#83a598"
    BRIGHT_PURPLE   = "#d3869b"
    BRIGHT_AQUA     = "#8ec07c"
    BRIGHT_ORANGE   = "#fe8019"
    NEUTRAL_RED     = "#cc241d"
    NEUTRAL_GREEN   = "#98971a"
    NEUTRAL_YELLOW  = "#d79921"
    NEUTRAL_BLUE    = "#458588"
    NEUTRAL_PURPLE  = "#b16286"
    NEUTRAL_AQUA    = "#689d6a"
    NEUTRAL_ORANGE  = "#d65d0e"
    FADED_RED       = "#9d0006"
    FADED_GREEN     = "#79740e"
    FADED_YELLOW    = "#b57614"
    FADED_BLUE      = "#076678"
    FADED_PURPLE    = "#8f3f71"
    FADED_AQUA      = "#427b58"
    FADED_ORANGE    = "#af3a03"

layout_defaults = dict(
    border_focus = Color.ACTIVE_WINDOW.value,
    border_normal = Color.INACTIVE_WINDOW.value,
    border_width = 2,
    single_border_width = 2,
)

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(**layout_defaults),
    layout.MonadWide(**layout_defaults),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="JetBrainsMono NF ExtraBold",
    fontsize=11,
    padding=3,
    background = Color.DARK0_HARD.value,
    foreground = Color.LIGHT0.value,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.TextBox(),
                widget.GroupBox(
                    borderwidth = 0,
                    spacing = 10,
                    fontsize=10,
                    highlight_method = "text",
                    active = Color.LIGHT4.value,
                    inactive = Color.NEUTRAL_RED.value,
                    this_current_screen_border = Color.FADED_BLUE.value,
                    use_mouse_wheel = False,
                ),
                widget.TextBox(":", padding = 8),
                widget.CurrentLayout(),
                widget.TextBox(":", padding = 8),
                widget.WindowName(foreground = Color.FADED_PURPLE.value),

                widget.GenPollText(
                    update_interval=600,
                    func=lambda: subprocess.check_output(["bar-gh-inbox"]).decode("utf-8")
                ),

                widget.Wttr(location = {"KCOS": ""}, format = "%c%t ● %h ● %w ● %m"),

                widget.Clock(format="%a"),
                widget.TextBox("●", fontsize = 14, foreground = Color.FADED_PURPLE.value),
                widget.Clock(format="%m/%d/%Y"),
                widget.TextBox("●", fontsize = 14, foreground = Color.FADED_BLUE.value),
                widget.Clock(format="%I:%M:%S %p"),

                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.TextBox(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
