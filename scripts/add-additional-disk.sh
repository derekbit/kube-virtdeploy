#!/bin/bash

FILESYSTEM=$1

echo ">>> Add additional disk"

DISK="/dev/vdb"
MOUNTPOINT="/mnt/disk"

echo -e "n\np\n1\n\n\nw" | fdisk ${DISK}

mkfs.${FILESYSTEM} ${DISK}1
mkdir -p ${MOUNTPOINT}

mount -t ${FILESYSTEM} ${DISK}1 ${MOUNTPOINT}
