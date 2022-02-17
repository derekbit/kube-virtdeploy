#!/bin/bash

echo ">>> Add additional disk"

DISK="/dev/vdb"
MOUNTPOINT="/mnt/disk"

echo -e "n\np\n1\n\n\nw" | fdisk ${DISK}

mkfs.ext4 ${DISK}1
mkdir -p ${MOUNTPOINT}

mount -t ext4 ${DISK}1 ${MOUNTPOINT}
