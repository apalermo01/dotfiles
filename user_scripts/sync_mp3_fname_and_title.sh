#!/usr/bin/env bash

if [[ $1 = '-h' ]]; then 
    echo "Looks for mp3 files in ~/Documents/Podcasts and syncs filename and title"
    exit 0
fi

if [[ ! -d ~/Documents/Podcasts/ ]]; then
    echo "~/Documents/Podcasts/ not found"
    exit 1
fi

cd ~/Documents/Podcasts

for f in *;
do
    if [[ -f ${f} ]]; then
        echo "updating title for ${f}"
        id3v2 --TIT2 "${f}" "${f}"
    fi
done;
