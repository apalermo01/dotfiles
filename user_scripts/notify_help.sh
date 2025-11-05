#!/usr/bin/env bash 


if [[ $1 = '-h' ]]; then 
    echo "Send a notification with common keybindings"
    exit 0
fi

notify-send keybindings: "
\$mod+Ctrl+s:  script selector\n\
\$mod+Ctrl+n:  notes selector\n\
\$mod+shfit+b: workspace back and forth\n\
\$mod+Ctrl+h:  tile horizontally\n\
\$mod+Shift+v: tile vertically\n\
\$mod+q:       toggle split method\n\
\$mod+s:       split layout\n\
\$mod+c:       stacked layout\n\
\$mod+t:       tabbed layout\n\
\$mod+Shift+s: screenshot\n\
\$mod+Shift+f: toggle fullscreen\n\
\$mod+Shift+-: move to scratchpad\n\
\$mod+r:       resize\n\
\$mod+g:       adjust gaps\n\
\$mod+u/y/m:   borders\n\



"
