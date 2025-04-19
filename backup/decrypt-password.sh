#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"
export RESTIC_PASSWORD=$(gpg --quiet --decrypt "$PASSWORD_FILE")

# This path assumes you’ve already configured Rclone under that name.
export RESTIC_REPOSITORY="$HOME/mnt/proton"

exec "$@"
