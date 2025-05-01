#!/bin/bash

BACKUP_DIR="$HOME/backups"
API_DIR="/home/hamisi/Documents/projects/hamisi-api"
DB_NAME="hamisi-assignment"
DB_USER="root"
DB_PASS=""


LOG_FILE="$HOME/backup.log"
DATE=$(date +%F)

mkdir -p "$BACKUP_DIR"

API_BACKUP="$BACKUP_DIR/api_backup_${DATE}.tar.gz"
DB_BACKUP="$BACKUP_DIR/db_backup_${DATE}.sql"

# /opt/lampp/bin/mysqldump -u $DB_USER -p$DB_PASS -S /opt/lampp/var/mysql/mysql.sock $DB_NAME > $DB_BACKUP


echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🔄 Starting backup..." >> "$LOG_FILE"


if tar -czf "$API_BACKUP" "$API_DIR"; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')]  API backup successful: $API_BACKUP" >> "$LOG_FILE"
else
  echo "[$(date '+%Y-%m-%d %H:%M:%S')]  API backup failed!" >> "$LOG_FILE"
fi


MySQL:
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $DB_BACKUP


if [ -f "$DB_BACKUP" ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')]  DB backup successful: $DB_BACKUP" >> "$LOG_FILE"
else
  echo "[$(date '+%Y-%m-%d %H:%M:%S')]  DB backup failed!" >> "$LOG_FILE"
fi


find "$BACKUP_DIR" -type f -mtime +7 -exec rm -f {} \;
