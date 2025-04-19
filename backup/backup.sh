#!/usr/bin/env bash
set -euo pipefail

notify-send "Restic Backup" "Backup is starting..."

MOUNT_PATH="$HOME/mnt/proton"
if ! mountpoint -q "$MOUNT_PATH" || [ ! -r "$MOUNT_PATH/keys" ]; then
  echo "[ERROR] Proton Drive is not mounted. Skipping backup." >&2
  exit 1
fi

restic backup /home/alex/ \
  --exclude '**/.cache' \
  --exclude '**/node_modules' \
  --exclude '**/.local/share/Trash'

restic forget --keep-last 7 --prune

notify-send "Restic Backup" "Backup completed successfully to Proton Drive"
