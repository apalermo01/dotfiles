#!/usr/bin/env bash

BASEDIR="${HOME}/Documents/git/notes/"

if [[ $1 = '-h' ]]; then 
    echo "Open a note in ${BASEDIR}"
    exit 0
fi

choice=$(find ~/Documents/git/notes/ \
    -name 5-Templates -prune -o \
    -name '*.md' -type f -print0 |

while IFS= read -r -d '' file; do
    name=$(echo "${file}" | sed "s|$BASEDIR||")
    printf "%s\n" "${name}"
done |
    rofi -dmenu -i -p "select a note: ")

case $choice in 
    *.md) 
        if tmux list-clients &>/dev/null; then
            notify-send "opening $choice in new tmux pane"
            pane_id=$(tmux new-window -n notes -P -F "#{pane_id}")
            tmux send-keys -t $pane_id "cd ${BASEDIR}" C-m
            tmux send-keys -t $pane_id "nvim ${BASEDIR}/${choice}" C-m
        else
            notify-send "opening $choice"
            setsid -f kitty --hold -e nvim "$BASEDIR$choice" &
        fi;;
esac

