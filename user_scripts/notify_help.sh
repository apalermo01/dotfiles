#!/usr/bin/env bash 


if [[ $1 = '-h' ]]; then 
    echo "Send a notification with common keybindings"
    exit 0
fi

notify-send keybindings: "
\$mod+shfit+b: workspace back and forth\n\
\$mod+Ctrl+h:  tile horizontally\n\
\$mod+Shift+v: tile vertically\n\
\$mod+q:       toggle split method\n\
\$mod+Shift+s: screenshot\n\
\$mod+s:       stacked layout\n\
\$mod+w:       tabbed layout\n\

"
