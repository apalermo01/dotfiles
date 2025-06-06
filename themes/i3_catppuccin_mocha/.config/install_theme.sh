#!/usr/bin/env bash

feh --bg-fill /home/alex/Pictures/wallpapers/darker_unicat.png
###!/usr/bin/env fish
kitty +kitten themes --reload-in=all catppuccin-macchiato
# fisher install catppuccin/fish
# fish_config theme save "Catppuccin Mocha"
# fish_config prompt save terlar

if [ -f ~/.config/polybar/i3_polybar_start.sh ]; then
    bash ~/.config/polybar/i3_polybar_start.sh
fi

# TODO: check distro before running these

# read -p "Install fish shell (y/n)?" choice
# case "$choice" in 
#     y|Y) echo "installing fish shell..." && sudo pacman -S fish;;
# esac

read -p "Install maple font? (y/n)?" choice
case "$choice" in 
    y|Y) echo "installing maple mono font..." && yay -S ttf-maple;;
esac
