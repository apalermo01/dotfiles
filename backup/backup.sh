#!/usr/bin/env bash
set -euo pipefail

notify-send "Restic Backup" "Backup is starting..."

restic backup /home/alex/ \
  --exclude '**/.cache' \
  --exclude '**/node_modules' \
  --exclude '**/.local/share/Trash'

restic forget --keep-last 7 --prune

notify-send "Restic Backup" "Backup completed successfully to Proton Drive"
