#!/usr/bin/env bash

if [[ $1 = '-h' ]]; then 
    echo "Switch keyboard layout via the terminal"
    exit 0
fi

echo "switching kb layout"

cfg_path="${HOME}/Documents/git/dotfiles/templates/global-before.yml"
wsl_cfg_path="${HOME}/Documents/git/dotfiles/templates/global-before.yml"
current_theme_path="${HOME}/Documents/git/dotfiles/current_theme"
current_theme=$(cat "${current_theme_path}")
colemak_line='switch_kb_layout.sh c"'
qwerty_line='switch_kb_layout.sh q"'
target_layout=''
if grep -q "${colemak_line}" ${cfg_path}; then
    sed -i "s|${colemak_line}|${qwerty_line}|" ${cfg_path}
    sed -i "s|${colemak_line}|${qwerty_line}|" ${wsl_cfg_path}
    echo "changed global ricer config to qwerty"
    target_layout='qwerty'
else
    sed -i "s|${qwerty_line}|${colemak_line}|" ${cfg_path}
    sed -i "s|${qwerty_line}|${colemak_line}|" ${wsl_cfg_path}
    echo "changed global ricer config to colemak"
    target_layout='colemak'
fi

echo "re-initializing current theme..."
ricer switch --theme ${current_theme}
echo "changed layout to ${target_layout}"
