#!/usr/bin/env bash

TARGET="JBL VIBE BUDS"

if [[ $1 = '-h' ]]; then 
    echo "Connect or disconnect bluetooth device with hardcoded mac address"
    exit 0
fi

connect() {
    echo "running connect()"
    devices=$(bluetoothctl <<EOF 
devices
EOF
)
    mac=$(echo "$devices" | sed 's/Device/\n/g' | grep "${TARGET}" | cut -f 2 -d ' ')
    echo "Connecting to device $TARGET with mac address $mac"

    if [ -z "${mac}" ]; then
        echo "no device with this name found"
        echo "available devices: "
        echo "$devices" | sed 's/Device/\n/g' | tail -n +2
        exit 1
    fi

    bluetoothctl connect $mac
    new_default_id=$(wpctl status | awk '/Filters/{flag=1;next}/Streams/{flag=0}flag' | grep "${mac}.*Audio/Sink" | grep -oP "[0-9]+(?=\. )" | head -1)
    wpctl set-default $new_default_id

    echo "wpctl: set new default sink id"
    wpctl status | awk '/Filters/{flag=1;next}/Streams/{flag=0}flag' | grep '*'
    exit 0
}
# info exits 1 if nothing is connected
bluetoothctl info || connect

# if we're here, then we're already connected
read -rp "Are you sure you want to disconnect bluetooth? [y/n] " discon 

if [[ ${discon} =~ ^[yY]$ ]]; then 
    bluetoothctl disconnect
    default_id=$(wpctl status | awk '/Sinks/{flag=1;next}/Sources/{flag=0}flag' | grep 'Built-in Audio Analog Stereo' | grep -oP '[0-9]+(?=\. )' | head -1)
    wpctl set-default $default_id

    echo "wpctl: set new default sink id"
    wpctl status | awk '/Sinks/{flag=1;next}/Sources/{flag=0}flag' | grep '*'
fi

exit 0
