#!/usr/bin/env bash

plasma-apply-colorscheme TokyoNight
feh --bg-fill /home/alex/Pictures/wallpapers/spookyjs_upscayl_realesrgan-x4plus_x2.png
###!/usr/bin/env fish
feh --bg-fill $HOME/Pictures/wallappers/spookyjs_upscayl_realesrgan-x4plus_x2.png
               
# fish_config prompt save acidhub
# if test -e ~/.config/polybar/i3_polybar_start.sh
#     bash ~/.config/polybar/i3_polybar_start.sh
# end

if [ -f ~/.config/polybar/i3_polybar_start.sh ]; then
    bash ~/.config/polybar/i3_polybar_start.sh
fi
