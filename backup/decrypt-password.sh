#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
REMOTE_NAME=$(<"$CONFIG_DIR/remote-name.txt")
PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"
export RESTIC_PASSWORD=$(gpg --quiet --decrypt "$PASSWORD_FILE")
export RESTIC_REPOSITORY="rclone:${REMOTE_NAME}:restic-backup"
exec "$@"
