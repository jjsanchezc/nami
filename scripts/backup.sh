#!/usr/bin/env bash
set -e

app_path="/opt/finance-tracker"

for i in "$app_path"/data/*; do
  echo "old: $i"
  #i=$(rev | cut "$i" -d / -f 1 | rev) # Didn't work using bash,i'll use awk
  i=$(echo "$i" | awk -F'/' '{print $NF}')
  echo "new: $i"
  new_name="$app_path"/backups/backup_"$(date +"%Y-%m-%d_%H-%M-%S")"_"$i"
  rsync "$i" "$new_name"
done
