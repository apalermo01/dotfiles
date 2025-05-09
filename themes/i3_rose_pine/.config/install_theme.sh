#!/usr/bin/env bash

plasma-apply-colorscheme RosePineMoon
feh --bg-fill /home/alex/Pictures/wallpapers/leafy.png
# fisher install rose-pine/fish
# fish_config prompt save acidhub
# fish_config theme choose "Rosé Pine"

kitty +kitten themes --reload-in=all Rosé Pine

if [ -f ~/.config/polybar/i3_polybar_start.sh ]; then
    bash ~/.config/polybar/i3_polybar_start.sh
fi

# if test -e ~/.config/polybar/i3_polybar_start.sh
#     bash ~/.config/polybar/i3_polybar_start.sh
# end

