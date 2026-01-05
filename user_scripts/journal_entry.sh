#!/usr/bin/env bash 

if [[ ! -z $NOTES_PATH ]]; then 
    NOTES_PATH="${HOME}/Documents/git/notes"
fi

file_name=$(date +%F).md
path="${NOTES_PATH}/6-Journal/${file_name}"


if [[ ! -e "${path}" ]]; then 
    touch "${path}"
fi

nvim ${path}
