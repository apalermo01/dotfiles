#!/usr/bin/env bash



echo "" >> ~/.tmux.conf

echo "set -g window-status-current-format \"#[fg=#fab387,bg=default]█#[fg=#1e1e2e,bg=#fab387]#I#[fg=#fab387,bg=#1e1e2e,nobold,nounderscore,noitalics]█ #[fg=#cdd6f4,bg=#1e1e2e]#W#[fg=#1e1e2e,bg=default,nobold,nounderscore,noitalics]█\"" >> ~/.tmux.conf

echo "set -g window-status-format \"#[fg=#89b4fa,bg=default]█#[fg=#313244,bg=#89b4fa]#I#[fg=#89b4fa,bg=#313244,nobold,nounderscore,noitalics]█ #[fg=#cdd6f4,bg=#313244]#W#[fg=#313244,bg=default,nobold,nounderscore,noitalics]█\"" >> ~/.tmux.conf


