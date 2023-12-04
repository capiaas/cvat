#!/bin/bash

echo "Backup script for cvat triggered at $(date)"
backup_dir="cvat_backup"
mkdir -p "$backup_dir"

docker compose stop

docker run --rm --name temp_backup --volumes-from cvat_db -v $(pwd)/"$backup_dir":/backup ubuntu tar -czvf /backup/cvat_db.tar.gz /var/lib/postgresql/data
docker run --rm --name temp_backup --volumes-from cvat_server -v $(pwd)/"$backup_dir":/backup ubuntu tar -czvf /backup/cvat_data.tar.gz /home/django/data

docker compose up -d
echo "Backup script for cvat completed at $(date)"
