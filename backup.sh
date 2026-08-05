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
SOURCE_DIR="/path/to/source/directory"
LOGFILE="/path/to/log/file"


export RESTIC_REPOSITORY
export RESTIC_PASSWORD_FILE

if [ ! -d "$SOURCE_DIR" ]; then
	echo "Error : Source Directory not found: $SOURCE_DIR"
	exit 1
fi

echo "====================================================" >> "$LOGFILE"
echo "====== Backup Started: $(date) ======" >> "$LOGFILE"
echo "====================================================" >> "$LOGFILE"



restic backup "$SOURCE_DIR" \
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

