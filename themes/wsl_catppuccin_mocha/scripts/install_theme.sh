#!/usr/bin/env bash 

# install catpuccin tmux theme
if [[ ! -d ~/.config/tmux/plugins/catppuccin ]]; then 
    echo "~/.config/tmux/plugins/catppuccin/ not found. Installing plugin..."
    mkdir -p ~/.config/tmux/plugins/catppuccin
    git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi
