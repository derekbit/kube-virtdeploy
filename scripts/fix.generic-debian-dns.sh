#!/bin/bash
# see:
# https://github.com/lavabit/robox/issues/11
# https://github.com/lavabit/robox/issues/54


# Remove fixed DNS entries and disable DNSSEC, disable flaky caching, or emdns
tee <<EOF > /etc/resolved.conf
nameserver 8.8.8.8
EOF

#/etc/init.d/networking restart

echo "Fixed networking."

# verify with: systemd-resolve --status
