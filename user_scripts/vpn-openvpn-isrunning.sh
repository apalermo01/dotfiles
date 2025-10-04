#!/bin/sh
# taken from https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/vpn-openvpn-isrunning

if [[ $1 = '-h' ]]; then 
    echo "Utility for polybar to check if the vpn is connected"
    exit 0
fi

connection=$(pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1)

if [ -n "$connection" ]; then
    echo "VPN: is connected"
else 
    echo "VPN: not connected"
fi
