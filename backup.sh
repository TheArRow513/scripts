#!/bin/bash

#
# Restic Backup Script
# - Creates an incremental backup
# - Excludes cache directories
# - Applies a retention policy:
#     - Keep 7 daily snapshots
#     - Keep 4 weekly snapshots
#     - Keep 6 monthly snapshots
# - Logs all output to a log file

set -euo pipefail

# ==========================
# Configuration
# ==========================
RESTIC_REPOSITORY="sftp:<username>@<server-ip>:/path/to/backup/place"
RESTIC_PASSWORD_FILE="/path/to/password/file"

SOURCE_DIRS=(
    "/path/to/source/directory1"
    "/path/to/source/directory2"
    "/path/to/source/directory3"
)

LOGFILE="/path/to/log/file"

export RESTIC_REPOSITORY
export RESTIC_PASSWORD_FILE

for dir in "${SOURCE_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "Error: Source directory not found: $dir"
        exit 1
    fi
done

echo "====================================================" >> "$LOGFILE"
echo "====== Backup Started: $(date) ======" >> "$LOGFILE"
echo "====================================================" >> "$LOGFILE"

restic backup "${SOURCE_DIRS[@]}" \
    --exclude-caches \
    --tag incremental \
    >> "$LOGFILE" 2>&1

restic forget \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 6 \
    --prune \
    >> "$LOGFILE" 2>&1

echo "====================================================" >> "$LOGFILE"
echo "====== Backup Finished: $(date) ======" >> "$LOGFILE"
echo "====================================================" >> "$LOGFILE"
