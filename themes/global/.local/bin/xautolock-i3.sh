#!/usr/bin/env bash
exec ${pkgs.xautolock}/bin/xautolock \
     -time 1 \
     -locker "${pkgs.i3lock}/bin/i3lock -c 250000" \
     -notify 30 \
     -notifier "${pkgs.libnotify}/bin/notify-send -u critical -t 5000 'Locking in 30 seconds'"
