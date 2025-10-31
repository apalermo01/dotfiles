#!/usr/bin/env bash

set -e

i3_keys=(
    "bindsym \$mod+h focus left|bindsym \$mod+h focus left"
    "bindsym \$mod+n focus down|bindsym \$mod+j focus down"
    "bindsym \$mod+e focus up|bindsym \$mod+k focus up"
    "bindsym \$mod+i focus right|bindsym \$mod+l focus right"
    "bindsym \$mod+Shift+h move left|bindsym \$mod+Shift+h move left"
    "bindsym \$mod+Shift+n move down|bindsym \$mod+Shift+j move down"
    "bindsym \$mod+Shift+e move up|bindsym \$mod+Shift+k move up"
    "bindsym \$mod+Shift+i move right|bindsym \$mod+Shift+l move right"
    "bindsym \$mod+k layout stacking; exec notify-send 'stack layout. \$mod+t to tab'|bindsym \$mod+k layout stacking; exec notify-send 'stack layout. \$mod+t to tab'"
    "bindsym \$mod+t layout tabbed; exec notify-send 'tabbed layout. \$mod+k to stack'|bindsym \$mod+t layout tabbed; exec notify-send 'tabbed layout. \$mod+k to stack'"
)

tmux_keys=(
    "bind -n M-h previous-window|bind -n M-h previous-window"
    "bind -n M-i next-window|bind -n M-i next-window"
    "bind -n M-l last-window|bind -n M-l last-window"

    "set -g @vim_navigator_mapping_left 'C-Left C-h'|set -g @vim_navigator_mapping_left 'C-Left C-h'"
    "set -g @vim_navigator_mapping_right 'C-Right C-i'|set -g @vim_navigator_mapping_right 'C-Right C-l'"
    "set -g @vim_navigator_mapping_up 'C-Up C-e'|set -g @vim_navigator_mapping_up 'C-Up C-k'"
    "set -g @vim_navigator_mapping_down 'C-down C-n'|set -g @vim_navigator_mapping_down 'C-down C-j'"
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
        sed -i "s/${qwerty_key}/${colemak_key}/" ~/.tmux.conf
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
        sed -i "s/${colemak_key}/${qwerty_key}/" ~/.tmux.conf
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
