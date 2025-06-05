#!/usr/bin/env bash

find ~/Documents/git/notes/0-notes/ -name 3-tags -prune -o -name '*.md' -type f -exec sh -c 'echo $(basename "{}") \($(sed "s|2025|test|" {})\)' \;
# echo -e "$(command find ~/Documents/git/notes/0-notes -type f)" | dmenu -l 5 -i  -p "select a note: " 
