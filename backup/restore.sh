echo "Restore started at $(date)"

# Access the folder name from the first argument
folder_name="$1"
# Check if the folder exists
if [ ! -d "$folder_name" ]; then
  echo "Error: Folder '$folder_name' does not exist, please use absolute path."
  exit 1
fi

# Change to the specified directory
cd "$folder_name" || exit
ls
docker compose stop

docker run --rm --name temp_backup --volumes-from cvat_db -v $(pwd):/backup ubuntu bash -c "cd /var/lib/postgresql/data && tar -xvf /backup/cvat_db.tar.gz --strip 4"
docker run --rm --name temp_backup --volumes-from cvat_server -v $(pwd):/backup ubuntu bash -c "cd /home/django/data && tar -xvf /backup/cvat_data.tar.gz --strip 3"

docker compose up -d
echo "Restore completed at $(date)"