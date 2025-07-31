#!/bin/bash

# === CONFIGURATION ===
SOURCE_REMOTE_USER="root@micple.com" 
DEST_ROOT_FOLDER="/var/micple.com/backup"


MEDIA_SOURCE_DIR="${REMOTE_USER}:/var/micple.com/default.imp/storage.imp”
MEDIA_DEST_DIR="${DEST_ROOT_FOLDER}/media"

DB_SOURCE_DIR="${REMOTE_USER}:/var/lib/mongodb”
DB_DEST_DIR="${DEST_ROOT_FOLDER}/db”

# Create destination if it doesn't exist 
mkdir -p "$MEDIA_DEST_DIR"
mkdir -p "$DB_DEST_DIR"

# Run rsync with archive and delete
rsync -az --delete "$MEDIA_SOURCE_DIR/" "$MEDIA_DEST_DIR/"
rsync -az --delete "$DB_SOURCE_DIR/" "$DB_DEST_DIR/"

# Save backup time in README.md
BACKUP_TIME=$(date +"%d %B %Y, %I:%M%p")
echo "### Backup Time: $BACKUP_TIME" >> "$DEST_ROOT_FOLDER/README.md"
