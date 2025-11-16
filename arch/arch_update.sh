#!/usr/bin/env bash 

set -e 

LISTFILE="$HOME/Documents/git/dotfiles/arch/packages.list"

INSTALL () {
    sudo pacman -S $@
}

UNINSTALL () {
    sudo pacman -Rns $@
}

LIST () {
    sudo pacman -Qqen
}

parse_listfile () {
    sed -e 's/#.*$//' -e 's/[ \t]*//g' -e '/^\s*$/d' $1 | sort
}

diff_listfile () {
    diff -u <(parse_listfile $1) <(LIST | sort) | sed -n "/^[-+][^-+]/p" | sort
}

main () {
    if [ ! -z "$1" ]; then 
        LISTFILE="${1}"
    fi

    echo "updating arch system with listfile $LISTFILE"

    to_install=$(diff_listfile $LISTFILE | sed -n '/^-/s/^-//p')
    to_remove=$(diff_listfile $LISTFILE | sed -n '/^+/s/^+//p')
	echo "removing\n $to_remove"
	echo "installing\n $to_install"
	INSTALL $to_install
}

main $1
