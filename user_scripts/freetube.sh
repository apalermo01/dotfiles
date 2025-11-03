#!/usr/bin/env bash
# run freetube only if openvpn is running 

connection=$(pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1)

if [ -n "$connection" ]; then
    freetube "$@"
else 
    notify-send "Cannot start freetube. Openvpn not connected."
fi
