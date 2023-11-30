#!/bin/bash

echo "Backup script for cvat triggered at $(date)"
# Get the current date in the format YYYY-MM-DD
current_date=$(date +%Y%m%d)
backup_dir="/volumes/cvat_new/backup/$current_date"
# docker compose stop
mkdir "$backup_dir"
docker run --rm --name temp_backup --volumes-from cvat_db -v $(pwd)/"$backup_dir":/backup ubuntu tar -czvf /backup/cvat_db.tar.gz /var/lib/postgresql/data
docker run --rm --name temp_backup --volumes-from cvat_server -v $(pwd)/"$backup_dir":/backup ubuntu tar -czvf /backup/cvat_data.tar.gz /home/django/data

# docker compose up -d
echo "Backup script for cvat completed at $(date)"
