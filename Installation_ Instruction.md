# 🔄 Micple Backup Automation Setup Guide

This guide helps you automate file and MongoDB backups from a remote server using `rsync` and a cron job.

---

## 📁 1. Create Backup Script

Create a new shell script at `/usr/local/bin/micple_backup.sh`:

### ➤ Script: `/usr/local/bin/micple_backup.sh`

```bash
#!/bin/bash

# === CONFIGURATION ===
REMOTE_USER="root@micple.com"
DEST_ROOT_FOLDER="/var/micple.com/backup"

MEDIA_SOURCE_DIR="${REMOTE_USER}:/var/micple.com/default.imp/storage.imp"
MEDIA_DEST_DIR="${DEST_ROOT_FOLDER}/media"

DB_SOURCE_DIR="${REMOTE_USER}:/var/lib/mongodb"
DB_DEST_DIR="${DEST_ROOT_FOLDER}/db"

# Create destination if it doesn't exist 
mkdir -p "$MEDIA_DEST_DIR"
mkdir -p "$DB_DEST_DIR"

# Run rsync with archive and delete
rsync -az --delete "$MEDIA_SOURCE_DIR/" "$MEDIA_DEST_DIR/"
rsync -az --delete "$DB_SOURCE_DIR/" "$DB_DEST_DIR/"

# Save backup time in README.md
BACKUP_TIME=$(date +"%d %B %Y, %I:%M%p")
echo "### Backup Time: $BACKUP_TIME" >> "$DEST_ROOT_FOLDER/README.md"


``` 
---

## ⏰ 2. Schedule with Cron

To run the backup script every hour automatically:

### ➤ Edit Cron Jobs

```bash
crontab -e
``` 
### ➤ Add This Line at the Bottom
```bash
0 * * * * /usr/local/bin/micple_backup.sh >> /var/micple.com/backup/hourly-backup.log 2>&1
``` 

This command runs the backup script every hour on the hour and logs output to hourly-backup.log.


## 📦 Output Directory Structure

```markdown

/var/micple.com/backup/
├── media/                  # Remote media backup
├── db/                     # Remote MongoDB data backup
├── README.md               # Timestamp of each backup
└── hourly-backup.log       # Cron job logs
``` 
