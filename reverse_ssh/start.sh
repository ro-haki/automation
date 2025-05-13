#!/bin/bash
set -e

if ! mountpoint -q /data; then
    echo "Error: /data is not a mount point. Please mount it."
    exit 1
fi

: "${EXTERNAL_ADDRESS:?Error: EXTERNAL_ADDRESS is not set}"

touch /data/authorized_keys /data/authorized_controllee_keys

mkdir -p /ssh_keys
if [ ! -f /ssh_keys/id_ed25519 ]; then
    ssh-keygen -t ed25519 -f /ssh_keys/id_ed25519 -N "" -q
    cat /ssh_keys/id_ed25519.pub >> /data/authorized_keys
    echo "Generated new SSH keys."
fi

cd /app/bin
exec ./server --datadir /data --enable-client-downloads --tls --external_address $EXTERNAL_ADDRESS :2222