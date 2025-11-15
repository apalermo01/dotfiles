#!/usr/bin/env bash 

LISTFILE="~/Documents/git/dotfiles/arch/packages.list"

INSTALL () {
    sudo pacman -S $@
}

UNINSTALL () {
    sudo pacman -Rns --noconfirm $@
}

LIST () {
    pacman -Qqen
}

parse_listfile () {
    sed -e 's/#.*$//' -e 's/[ \t]*//g' -e '/^\s*$/d' $1 | sort
}

diff_listfile () {
    diff -u <(parse_listfile ~/packages.list) <(LIST | sort) | sed -n "/^[-+][^-+]/p" | sort
}

main () {
    to_install=$(diff_listfile | sed -n '/^-/s/^-//p')
    to_remove=$(diff_listfile | sed -n '/^+/s/^+//p')
	echo "removing\n $to_remove"
	echo "installing\n $to_install"
	INSTALL $to_install
}

main
