#!/usr/bin/env bash

if command -v plasma-apply-colorscheme; then
    plasma-apply-colorscheme TokyoNight
fi

dunstctl reload 
