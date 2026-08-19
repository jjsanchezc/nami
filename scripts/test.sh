#!/usr/bin/env bash

sourcee="${BASH_SOURCE[-1]}"
alo=$(dirname "$sourcee")

echo "${alo[@]}"
repo_dir=$(dirname "${BASH_SOURCE[0]}")
echo "$repo_dir"
