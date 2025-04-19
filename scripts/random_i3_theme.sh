#!/bin/bash

# Find all theme directories under ./themes/ that contain 'i3' in the name
themes=($(find ./themes -maxdepth 1 -type d -name '*i3*' -printf "%f\n"))

random_theme=${themes[RANDOM % ${#themes[@]}]}

bash ./scripts/switch_theme.sh $random_theme
