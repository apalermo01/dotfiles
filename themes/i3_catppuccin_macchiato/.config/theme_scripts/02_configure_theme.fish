#!/usr/bin/env fish
kitty +kitten themes --reload-in=all catppuccin-macchiato
fisher install catppuccin/fish
#fish_config theme save "Catppuccin Mocha"
fish_config theme save "Catppuccin Macchiato"
fish_config prompt save terlar

if test -e ~/.config/polybar/i3_polybar_start.sh
    bash ~/.config/polybar/i3_polybar_start.sh
end

