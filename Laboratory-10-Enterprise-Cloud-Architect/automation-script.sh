#!/bin/bash
# Daily backup of the WordPress database
set -o pipefail

BACKUP_DIR="$HOME/backups"
DATE=$(date +%F_%H-%M-%S)
FILE="$BACKUP_DIR/wordpress_$DATE.sql.gz"

mkdir -p "$BACKUP_DIR"

# Dump the database from inside the db container and compress it
if /usr/bin/docker exec ccmfinal_db sh -c 'exec mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --single-transaction wordpress' | gzip > "$FILE"; then
    echo "$(date): Backup OK -> $FILE"
else
    echo "$(date): Backup FAILED"
    rm -f "$FILE"
    exit 1
fi

# Delete backups older than 7 days
find "$BACKUP_DIR" -name "wordpress_*.sql.gz" -mtime +7 -delete
