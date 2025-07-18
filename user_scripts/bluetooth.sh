#!/usr/bin/env bash

connect() {
    bluetoothctl connect F0:A9:68:8A:80:20
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
