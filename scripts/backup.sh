#!/usr/bin/env bash

app_path="/opt/finance-tracker"

for i in "$app_path"/data/*; do
  i=$(rev "$i" | cut "$i" -d / -f 1 | rev)
  echo "$i"
  new_name="$app_path"/backups/backup_"$(date +"%Y-%m-%d_%H-%M-%S")"_"$i"
  rsync "$i" "$new_name"
done
