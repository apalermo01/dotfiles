#!/bin/bash

# Find all theme directories under ./themes/ that contain 'wsl' in the name
themes=($(find ./themes -maxdepth 1 -type d -name '*wsl*' -printf "%f\n"))

random_theme=${themes[RANDOM % ${#themes[@]}]}

bash ./switch_theme.sh $random_theme
