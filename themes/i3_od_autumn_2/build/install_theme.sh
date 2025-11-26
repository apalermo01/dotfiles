#!/usr/bin/env sh



if [ -f ~/.config/polybar/i3_polybar_start.sh ]; then

    bash ~/.config/polybar/i3_polybar_start.sh

fi


if command -v plasma-apply-colorscheme; then
    plasma-apply-colorscheme OneDarkRed
fi

dunstctl reload 
