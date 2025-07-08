#!/usr/bin/env bash


if [[ -d ~/.tmux/plugins/tmux ]]; then
    echo "removing ~/.tmux/plugins/tmux"
    sudo yes | rm -r ~/.tmux/plugins/tmux
fi
