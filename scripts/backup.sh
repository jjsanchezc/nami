#!/usr/bin/env bash
set -e

app_path="/opt/finance-tracker"
file_date=$(date +"%Y-%m-%d_%H-%M-%S")
for i in "$app_path"/data/*; do
  #i=$(rev | cut "$i" -d / -f 1 | rev) # Didn't work using bash,i'll use awk
  #i=$(echo "$i" | awk -F'/' '{print $NF}') # Unnecessary use of awk and echo
  filename="$(basename "$i")" # new var so i don't overwrite the path on line 11
  new_name="$app_path"/backups/backup_"$file_date"_"$filename"
  rsync "$i" "$new_name"
done
