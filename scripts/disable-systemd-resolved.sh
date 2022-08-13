#!/bin/bash

echo ">>> Disable systemd-resolved"

# Referece: https://support.tools/post/how-to-disable-systemd-resolved

systemctl disable systemd-resolved
systemctl stop systemd-resolved

# Remove the remove the existing /etc/resolv.conf file,
# which is currently a symbolic link to /run/systemd/resolve/stub-resolv.conf

rm -f /etc/resolv.conf

echo 'nameserver 168.195.1.1' >> /etc/resolv.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

sleep 5
