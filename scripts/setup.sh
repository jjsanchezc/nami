#!/usr/bin/env bash
set -e # exit the script if something in it fails

# check if sudo or root
if [[ "$EUID" -ne 0 ]]; then # if effective user id is not equal to 0 (root or sudo),
  echo "Sudo or root permission needed"
  exit 1
fi

# Variables
new_user=finance-svc
new_group=finance
new_dir=finance-tracker
app_path="/opt/$new_dir"
nologin_path="$(whereis nologin | cut -d ' ' -f 2)"  # to make sure whereis
repo_dir=$(dirname "$(dirname "${BASH_SOURCE[0]}")") # Always get nami/ dir

# Creating user
x="$(cat /etc/passwd | cut -d : -f 1 | grep -x $new_user)"
if [[ "$x" != "$new_user" ]]; then
  echo "creating user"
  useradd "$new_user" -Ns "$nologin_path" # create the user without creating a homonym group (-N) and no login shell (-s nologin_path)
fi

# Create the finance group
groupadd "$new_group" -f # Create finance group without duplicates (-f)

# Add users to the group
usermod "$new_user" -aG "$new_group"
usermod jjsanchezc -aG "$new_group"

# Set shared dir (finance_tracker)
# necesito darle permisos al grupo finance pero tambien que sea el dueno
mkdir -p "$app_path"
chown "$new_user":"$new_group" "$app_path"
chmod 2775 "$app_path"
umask 002

mkdir -p "$app_path"/data
mkdir -p "$app_path"/backups
cp "$repo_dir"/requirements.txt "$app_path"/requirements.txt
rsync -a --delete "$repo_dir"/src/ "$app_path"/src/
rsync -a --delete "$repo_dir"/scripts/ "$app_path"/scripts/
rsync -a --delete "$repo_dir"/systemd/ "$app_path"/systemd/

# App and python config
apt update && apt install python3 -y
apt install python3-venv -y
apt install sqlite3 -y

python3 -m venv "$app_path"/venv
source "$app_path"/venv/bin/activate

if [[ -f "$app_path"/requirements.txt ]]; then
  pip3 install -r "$app_path"/requirements.txt
fi

python3 "$app_path"/src/db.py
echo "db.py executed correctly"

# System units config
service_path=/etc/systemd/system

cp -r "$repo_dir"/systemd/. "$service_path"/

systemctl daemon-reload
# right now is just one service that needs to be activated, but in case that the units grow, think about
# some loops or cases to solve it (ADR-000)
systemctl enable "$service_path"/finance-backup.timer --now
