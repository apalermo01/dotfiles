#!/usr/bin/env bash


BASEDIR="${HOME}/Scripts"

if [[ $1 = '-h' ]]; then 
    echo "List scripts in ${BASEDIR} and run them or show help"
    exit 0
fi

if ! command -v rofi; then
    echo "Rofi not found, exiting..."
fi

choice=$(find "${BASEDIR}" -name "*.sh" -print0 | while read -r -d '' file; do 
    name=$(echo "${file}" | sed "s|$BASEDIR||")
    printf "%s\n" "${name}"
done |  rofi -dmenu -i -p "available scripts")

if ! $choice; then 
    exit(0) 
fi

cmd=$(printf "run\nview help" | rofi -dmenu -i -p "What to do with ${choice}?")

case $cmd in 
    "run")
        notify-send "running $choice"
        kitty "${BASEDIR}/${choice}";;
    *) 
        msg=$("${BASEDIR}/${choice}" -h)
        notify-send "${msg}"
        ;;
esac

