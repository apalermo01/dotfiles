#!/usr/bin/env bash 

LISTFILE="~/Documents/git/dotfiles/arch/packages.list"

INSTALL () {
    sudo pacman -S --noconfirm $@
}

UNINSTALL () {
    sudo pacman -Rns --noconfirm $@
}

LIST () {
    pacman -Qqen
}

parse_listfile () {
    sed -e 's/#.*$//' -e 's/[ \t]*//g' -e '/^\s*$/d' $1 sort
}

diff_listfile () {
    diff -u <(parse_listfile) <(LIST | sort) | sed -n "/^[-+][^-+]/p" | sort
}

main () {
    difffile | sed -n '/^-/s/^-//p'
}

main
