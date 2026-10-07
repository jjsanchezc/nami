#!/usr/bin/env bash
set -e

if [[ "$EUID" -ne 0 ]]; then
  echo "sudo root permission needed"
  exit 1
fi

repo_dir=$(dirname "$(dirname "${BASH_SOURCE[0]}")") # Always get nami/ dir

# Get all .conf files and send it to /etc/ssh/sshd_config.d/ to overwrite rules
cp "$repo_dir"/scripts/conf/*.conf /etc/ssh/sshd_config.d/
systemctl restart sshd

# Allow 1222 as the only incoming port (with tcp)
ufw allow 1222/tcp

# Deny incoming traffic
ufw default deny incoming
ufw --force enable
