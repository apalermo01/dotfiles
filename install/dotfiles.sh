#!/usr/bin/env bash

ggit@github.com:apalermoit_root="$HOME/Documents/git"
mkdir -p "$git_root"

if command -v nix-shell >/dev/null; then
    nix-shell -p git --command "
        cd $git_root && git clone git@github.com:apalermo01/dotfiles && cd $git_root/dotfiles
    "
else
    cd $git_root
    git clone git@github.com:apalermo01/dotfiles.git
    cd "$git_root/dotfiles"
fi

cd $git_root/dotfiles

echo "Dotfiles repo has been cloned and installed."
