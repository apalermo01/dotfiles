#!/usr/bin/env bash
set -euo pipefail

notify-send "Restic Backup" "Backup is starting..."

CONFIG_DIR="$HOME/.config/restic-setup"
EMAIL_FILE="$CONFIG_DIR/email.txt"
EMAIL=$(cat "$EMAIL_FILE" 2>/dev/null || echo "")

BACKUP_LOG=$(mktemp /tmp/restic-backup.XXXXXX.log)
trap 'rm -f "$BACKUP_LOG"' EXIT

echo "[INFO] Starting restic backup at $(date)" >> "$BACKUP_LOG"
START=$(date +%s)

restic backup /home/alex/ \
  --exclude '**/.cache' \
  --exclude '**/node_modules' \
  --exclude '**/.local/share/Trash' \
  >> "$BACKUP_LOG" 2>&1 && SUCCESS=1 || SUCCESS=0

restic forget --keep-last 7 --prune >> "$BACKUP_LOG" 2>&1

END=$(date +%s)
RUNTIME=$((END - START))

# Short summary
if [[ $SUCCESS -eq 1 ]]; then
    STATUS="✅ Backup succeeded"
else
    STATUS="❌ Backup failed"
fi

SUMMARY="$STATUS on $(hostname) at $(date)
Duration: ${RUNTIME}s
Log excerpt:
$(tail -n 10 "$BACKUP_LOG")"

notify-send "Restic Backup" "Backup completed successfully to Proton Drive"

# Email or fallback log
if [[ -n "$EMAIL" ]]; then
    echo "$SUMMARY" | mail -s "Restic Backup Report: $STATUS" "$EMAIL"
else
    echo "$SUMMARY"
fi
