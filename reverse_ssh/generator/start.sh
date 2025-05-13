#!/bin/bash
set -e

if [ "$#" -gt 0 ]; then
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null reverse-ssh -p 2222 -i /ssh_keys/id_ed25519 "$@"
else
    echo "No command for execution"
fi

reverse_ssh_data="/data"
shells_and_executions="/shells_and_executions"
sqlite_output=$(sqlite3 "$reverse_ssh_data/data.db" "select url_path, file_path from downloads")

echo 'Copy from data to share. Content of data.db:'

sqlite3 "$reverse_ssh_data/data.db" "select url_path, file_path, file_type from downloads" | while IFS='|' read -r url_path file_path file_type; do
    echo "url_path: $url_path, file_path: $file_path, file_type: $file_type"
    if [ -n "$url_path" ] && [ -n "$file_path" ] && [ -f "$file_path" ]; then
        chmod 777 $file_path
        cp  "$file_path" "$shells_and_executions/${url_path}.exe"
    else
        echo "Skipping invalid entry in ssh reverse data: url='$url', file='$file'" >&2
    fi
done