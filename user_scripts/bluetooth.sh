#!/usr/bin/env bash

connect() {
    bluetoothctl connect B4:84:D5:C0:05:03 
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
