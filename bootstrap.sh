#!/usr/bin/bash

sudo nixos-rebuild switch \
    --flake github:apalermo01/dotfiles/nix#nixos \
    --extra-experimental-features nix-command
