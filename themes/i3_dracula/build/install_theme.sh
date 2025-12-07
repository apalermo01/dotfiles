#!/usr/bin/env bash



if [ -f ~/.config/polybar/i3_polybar_start.sh ]; then

    bash ~/.config/polybar/i3_polybar_start.sh

fi



ya pack -a yazi-rs/flavors:dracula
dunstctl reload 
