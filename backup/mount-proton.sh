#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/restic-setup"
REMOTE_NAME=$(<"$CONFIG_DIR/remote-name.txt")  # read from file
REMOTE="${REMOTE_NAME}:${REMOTE_NAME}"
MOUNT_PATH="$HOME/mnt/proton"


exec rclone mount "$REMOTE" "$MOUNT_PATH" \
  --vfs-cache-mode writes \
  --allow-other \
  --config "${CONFIG_DIR}/rclone.conf" \
  --log-file "$HOME/.local/share/rclone/proton-mount.log"
