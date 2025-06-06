#!/usr/bin/env bash

export DMENU_SCRIPT_BASEDIR="${HOME}/Documents/git/notes/0-notes"

find ~/Documents/git/notes/0-notes/ \
    -name 3-tags -prune -o \
    -name '*.md' -type f -print0 |
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    basedir=$(dirname "$file" | sed "s|$DMENU_SCRIPT_BASEDIR||")
    printf "%-70s %-60s\n" "$filename" "$basedir"
done | 
dmenu -l 5 -i -p "select a note: "

