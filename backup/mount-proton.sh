#!/usr/bin/env bash

mkdir -p "$HOME/.local/share/rclone"
exec rclone mount proton:proton-restic-backup ~/mnt/proton \
  --vfs-cache-mode writes \
  --allow-other \
  --log-file "$HOME/.local/share/rclone/proton-mount.log"
