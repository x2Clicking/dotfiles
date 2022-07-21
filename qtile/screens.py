from config import *
from libqtile import bar, widget
from libqtile.config import Drag, Click, Screen
from libqtile.lazy import lazy
from shortcuts import mod
from utils import loadtheme

theme = loadtheme()

screens = [
    Screen(
        top = bar.Bar(
            [
                widget.GroupBox(
                        font='Agave Nerd Font',
                        fontsize= 16,
                        margin_x = -1,
                        spacing = 2,
                        highlight_method='line',
                        background = theme["bar"]["groupbox"]["background"],
                        active= theme["bar"]["groupbox"]["active"],
                        inactive= theme["bar"]["groupbox"]["inactive"],
                        this_current_screen_border = [theme["bar"]["groupbox"]["this_current_screen_border"]],
                        other_current_screen_border = [theme["bar"]["groupbox"]["line_active"]],
                        highlight_color = theme["bar"]["groupbox"]["line_hilight_color"],
                        other_screen_border = theme["bar"]["groupbox"]["other_screen_border"],
                        disable_drag = True,
                        rounded = False,
                        center_aligned = True
                    ),
                widget.WindowName(
                    fontsize=16,
                    padding = 500,
                    background= theme["widgets"]["background"], 
                    foreground= theme["widgets"]["window-name-font-color"],
                    format='{name}',
                    max_chars = 30,
                    ),
                widget.TextBox(
                    text="\ue0b2",
                    fontsize = 34,
                    background= theme["widgets"]["background"], 
                    foreground= theme["widgets"]["colors"]["four"], 
                    padding = -1
                    ),
                widget.TextBox(
                    text= ' ',
                    foreground= theme["widgets"]["font-color"], 
                    background = theme["widgets"]["colors"]["four"]
                ),
                widget.CurrentLayout(
                    foreground= theme["widgets"]["font-color"], 
                    background= theme["widgets"]["colors"]["four"]
                ),
                widget.TextBox(
                    text="\ue0b2",
                    fontsize = 34,
                    background = theme["widgets"]["colors"]["four"],
                    foreground = theme["widgets"]["colors"]["three"],
                    padding = -1
                ),
                widget.TextBox(
                    text='',
                    foreground = theme["widgets"]["font-color"],
                    background = theme["widgets"]["colors"]["three"]
                ),
                widget.Clock(
                    fromat = '%I:%M %p', 
                    foreground= theme["widgets"]["font-color"], 
                    background= theme["widgets"]["colors"]["three"]
                ),
                widget.TextBox(
                    text="\ue0b2",
                    fontsize = 34,
                    background = theme["widgets"]["colors"]["three"],
                    foreground = theme["widgets"]["colors"]["two"],
                    padding = -1
                ),
                widget.TextBox(
                    text='',
                    foreground = theme["widgets"]["font-color"],
                    background = theme["widgets"]["colors"]["two"]
                ),
                widget.Clock(
                    format= '%d/%m/%Y', 
                    foreground= theme["widgets"]["font-color"],  
                    background= theme["widgets"]["colors"]["two"]
                ),
                widget.TextBox(
                    text="\ue0b2",
                    fontsize = 34,
                    background = theme["widgets"]["colors"]["two"],
                    foreground = theme["widgets"]["colors"]["one"],
                    padding = -1
                ),
                widget.TextBox(
                    text= ' ',
                    mouse_callbacks={'Button1': lazy.spawn('eww open power')},
                    foreground= theme["widgets"]["font-color"], 
                    background = theme["widgets"]["colors"]["one"] 
                )
            ],
            32,
            margin = [10,5,10,5],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
