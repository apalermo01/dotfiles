#!/usr/bin/env bash

feh --bg-fill /home/apalermo/Pictures/wallpapers/synth.jpg
###!/usr/bin/env fish
# kitty +kitten themes --reload-in=all catppuccin-macchiato
# fisher install dracula/fish
# fish_config theme choose "Dracula Official"
# fish_config prompt save terlar

# if test -e ~/.config/polybar/i3_polybar_start.sh
#     bash ~/.config/polybar/i3_polybar_start.sh
# end

if [ -f ~/.config/polybar/i3_polybar_start.sh ]; then
    bash ~/.config/polybar/i3_polybar_start.sh
fi
