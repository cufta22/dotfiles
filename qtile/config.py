# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, hook, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder

# Colors

colors = {
    "rosewater"   : "#f4dbd6",
    "flamingo"    : "#f0c6c6",
    "pink"        : "#f5bde6",
    "mauve"       : "#c6a0f6",
    "red"         : "#ed8796",
    "maroon"      : "#ee99a0",
    "peach"       : "#f5a97f",
    "yellow"      : "#eed49f",
    "green"       : "#a6da95",
    "teal"        : "#8bd5ca",
    "sky"         : "#91d7e3",
    "sapphire"    : "#7dc4e4",
    "blue"        : "#8aadf4",
    "lavender"    : "#b7bdf8",
    "text"        : "#cad3f5",
    "subtext1"    : "#b8c0e0",
    "subtext0"    : "#a5adcb",
    "overlay2"    : "#939ab7",
    "overlay1"    : "#8087a2",
    "overlay0"    : "#6e738d",
    "surface2"    : "#5b6078",
    "surface1"    : "#494d64",
    "surface0"    : "#363a4f",
    "base"        : "#24273a",
    "mantle"      : "#1e2030",
    "crust"       : "#181926"
}

mod = "mod4"
terminal = "alacritty"

# █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █▀
# █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ ▄█

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle E tween different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),    
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Spawn a command using a prompt widget"),


##CUSTOM
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 5%+"), desc='Volume up 5%'),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 5%-"), desc='volume down 5%'),
    Key([mod], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 2%+"), desc='Volume up 2%'),
    Key([mod], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 2%-"), desc='volume down 2%'),

    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle"), desc='Volume Mute'),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc='playerctl'),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc='playerctl'),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc='playerctl'),

    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 10%+"), desc='brightness up'),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-"), desc='brightness down'),
    
##Other stuff
	Key([], "Print", lazy.spawn("flameshot gui"), desc='Screenshot'),
    Key([mod], "Print", lazy.spawn("flameshot gui -d 2000"), desc='Screenshot with delay'),
]   

# █▀▀ █▀█ █▀█ █░█ █▀█ █▀
# █▄█ █▀▄ █▄█ █▄█ █▀▀ ▄█



groups = [
    Group("1", label="🔴"),
    Group("2", label="🔴"),
    Group("3", label="🔴"),
    Group("4", label="🔴"),
    Group("5", label="🔴")
]

for i in groups:
    keys.extend(
            [
                Key(
                    [mod],
                    i.name,
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                    ),
                Key(
                    [mod, "shift"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                ]
            )


###𝙇𝙖𝙮𝙤𝙪𝙩###

layouts = [
    layout.MonadTall(	
        border_focus   = colors["sapphire"],
	    border_normal  = colors["base"],
	    margin         = 12,
	    border_width   = 2,
	),
    layout.Floating(	
        border_focus   = colors["sapphire"],
	    border_normal  = colors["base"],
	    margin         = 12,
	    border_width   = 2,
	),
    layout.Spiral(
        border_focus   = colors["sapphire"],
	    border_normal  = colors["base"],
	    margin         = 12,
	    border_width   = 2,
    )
]
            
# █▄▄ ▄▀█ █▀█
# █▄█ █▀█ █▀▄
 
screens = [
    Screen(
        top=bar.Bar(
            [
				widget.Spacer(
                    length = 10,
                ),

                widget.Image(
                    filename  = '~/.config/qtile/assets/bar/qtile.png',
                    margin    = 7,
                ),

                widget.Spacer(
                    length = 20,
                ),

                widget.GroupBox(
                    fontsize                    = 20,
                    margin_y                    = 3,
                    margin_x                    = 5,
                    borderwidth                 = 0,
                    font                        = "Roboto, Regular",
                    active                      = colors["green"],
                    block_highlight_text_color  = colors["red"],
                    inactive                    = colors["sapphire"],
                    rounded                     = True,
                    disable_drag                = True,
                 ),

                # ----------------------------------------

                widget.Spacer(
                    length = bar.STRETCH,
                ),

                # ----------------------------------------                 
  
                widget.Image(
                    filename  = '~/.config/qtile/assets/bar/sun.png',
                    margin    = 8,
                ),
                widget.Backlight(
                    font                 = "Roboto, Regular",
                    foreground           = colors["yellow"],
                    brightness_file      = "/sys/class/backlight/intel_backlight/actual_brightness",
                    max_brightness_file  = "/sys/class/backlight/intel_backlight/max_brightness",
                    fontsize             = 12,
                    padding              = 0,
                ),

                widget.Spacer(
                    length = 16,
                ), 

                widget.Image(
                    filename  = '~/.config/qtile/assets/bar/vol.png',
                    margin    = 8,
                ),
                widget.PulseVolume(
                    font        = "Roboto, Regular",
                    foreground  = colors["blue"],
                    fontsize    = 12,
                    padding     = 0,
                ),

                widget.Spacer(
                    length = 16,
                ),                       

                widget.Image(
                    filename  = '~/.config/qtile/assets/bar/bat.png',
                    margin    = 7
                ),         
                widget.Battery(format=' {percent:2.0%}',
                    font        = "Roboto, Regular",
                    foreground  = colors["red"],
                    fontsize    = 12,
                    padding     = 0,
                ),         

                widget.Spacer(
                    length = 30,
                ),
                widget.Spacer(
                    length      =10,
                    background  = colors["surface0"]
                ), 
                widget.Systray(
                    icon_size   = 24,
                    padding     = 0,
                    background  = colors["surface0"]
                ),   
                widget.Spacer(
                    length      = 10,
                    background  = colors["surface0"]
                ), 
                widget.Spacer(
                    length = 20,
                ),
        
                widget.Clock(
                    format  ='%I:%M %p',
                    font    ="Roboto, Regular",
                ),
                 widget.Spacer(
                    length = 10,
                ),

                widget.CurrentLayoutIcon(
                    padding  = 0,
                    scale    = 0.6,
                    # Can't get this to work
                    # custom_icon_paths = [
                    #     '~/.config/qtile/assets/layout', 
                    # ]
                ),

                widget.Image(
                    filename         = '~/.config/qtile/assets/bar/power.png',
                    margin           = 8,
                    mouse_callbacks  = {
                        'Button1': lambda: qtile.cmd_spawn('rofi -show power')
                    }
                ),

                # qtile.cmd_spawn("rofi -show drun")

                widget.Spacer(
                    length = 10,
                ),
            ],
            40,
            margin      = [12, 12, 12, 12],
            background  = colors["base"]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
	border_focus   = colors["sapphire"],
    border_normal  = colors["base"],
    margin         = 12,
    border_width   = 2,
)

from libqtile import hook
import os
import subprocess

@hook.subscribe.startup_once
def autostart():
    # chmod +x ~/.config/qtile/autostart.sh
    path = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([path])

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
# wmname = "LG3D" # nope
wmname = "Qtile"
