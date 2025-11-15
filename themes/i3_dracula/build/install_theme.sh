#!/usr/bin/env bash



if [ -f ~/.config/polybar/i3_polybar_start.sh ]; then

    bash ~/.config/polybar/i3_polybar_start.sh

fi



ya pack -a yazi-rs/flavors:dracula
if command -v plasma-apply-colorscheme; then
    plasma-apply-colorscheme Dracula
fi

dunstctl reload 
