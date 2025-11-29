#!/usr/bin/env bash

set -e

i3_keys=(
    "include ~/.config/i3/colemak.conf|include ~/.config/i3/qwerty.conf"
)

tmux_keys=(
    "bind -n M-p previous-window|bind -n M-p previous-window"
    "bind -n M-I next-window|bind -n M-L next-window"
    "bind -n M-H last-window|bind -n M-H last-window"

    "set -g @vim_navigator_mapping_left 'C-Left M-h'|set -g @vim_navigator_mapping_left 'C-Left M-h'"
    "set -g @vim_navigator_mapping_right 'C-Right M-i'|set -g @vim_navigator_mapping_right 'C-Right M-l'"
    "set -g @vim_navigator_mapping_up 'C-Up M-e'|set -g @vim_navigator_mapping_up 'C-Up M-k'"
    "set -g @vim_navigator_mapping_down 'C-down M-n'|set -g @vim_navigator_mapping_down 'C-down M-j'"
)

colemak_i3() {
    if [ -d ~/.config/i3 ]; then 
        for k in "${i3_keys[@]}"; do
            colemak_key=$(echo "${k}" | cut -d '|' -f 1)
            qwerty_key=$(echo "${k}" | cut -d '|' -f 2)
            sed -i "s/${qwerty_key}/${colemak_key}/" ~/.config/i3/config
        done
    fi

}

colemak_nvim() {
    sed -i "s/-- require(\"config.colemak\")/require(\"config.colemak\")/" -i ~/.config/nvim/lua/config/init.lua
}

colemak_tmux() {
    for k in "${tmux_keys[@]}"; do
        colemak_key=$(echo "${k}" | cut -d '|' -f 1)
        qwerty_key=$(echo "${k}" | cut -d '|' -f 2)
        sed -i "s/${qwerty_key}/${colemak_key}/" ~/.config/tmux/tmux.conf
    done

}

qwerty_i3() {
    if [ -d ~/.config/i3 ]; then
        for k in "${i3_keys[@]}"; do
            colemak_key=$(echo "${k}" | cut -d '|' -f 1)
            qwerty_key=$(echo "${k}" | cut -d '|' -f 2)
            sed -i "s/${colemak_key}/${qwerty_key}/" ~/.config/i3/config
        done
    fi
}

qwerty_nvim() {
    sed -i "s/require(\"config.colemak\")/-- require(\"config.colemak\")/" -i ~/.config/nvim/lua/config/init.lua
}

qwerty_tmux() {
    for k in "${tmux_keys[@]}"; do
        colemak_key=$(echo "${k}" | cut -d '|' -f 1)
        qwerty_key=$(echo "${k}" | cut -d '|' -f 2)
        sed -i "s/${colemak_key}/${qwerty_key}/" ~/.config/tmux/tmux.conf
    done
}

colemak_layout() {
    colemak_i3
    colemak_nvim
    colemak_tmux
}

qwerty_layout() {
    qwerty_i3
    qwerty_nvim
    qwerty_tmux
}

usage() {
    echo "usage: "
    echo "switch to colemak layout: switch_kb_layout.sh c"
    echo "switch to qwerty layout:  switch_kb_layout.sh q"
    exit
}

if [ "$#" -ne 1 ]; then
    usage
fi

case $1 in 
    c) colemak_layout 
       echo "switched key mappings to colemak layout" ;;
    q) qwerty_layout 
       echo "switched key mappings to qwerty layout" ;;
    *) usage ;;
esac
