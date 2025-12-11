#!/usr/bin/env bash

if [[ $1 = '-h' ]]; then 
    echo "Connect or disconnect bluetooth device with hardcoded mac address"
    exit 0
fi

connect() {

    # Alex headset 2
    # bluetoothctl connect F0:A9:68:8A:80:20

    # Anna's headset
    bluetoothctl connect FF:B1:D9:AF:76:5A
    exit 0
}
# info exits 1 if nothing is connected
bluetoothctl info || connect

# if we're here, then we're already connected
read -rp "Are you sure you want to disconnect bluetooth? [y/n] " discon 

if [[ ${discon} =~ ^[yY]$ ]]; then 
    bluetoothctl disconnect
fi

exit 0
