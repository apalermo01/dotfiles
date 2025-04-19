#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/restic-setup"
REMOTE_NAME=$(<"$CONFIG_DIR/remote-name.txt")  # read from file
REMOTE="${REMOTE_NAME}:restic-backup"
MOUNT_PATH="$HOME/mnt/proton"

mkdir -p "$MOUNT_PATH"
mkdir -p "$HOME/.local/share/rclone"

exec rclone mount "$REMOTE" "$MOUNT_PATH" \
  --vfs-cache-mode writes \
  --allow-other \
  --log-file "$HOME/.local/share/rclone/proton-mount.log"
