#!/bin/bash

FILESYSTEM=$1
SIZE=$2

echo ">>> Add additional disk"

if [ "$SIZE" == "0" ]; then
  exit 0
fi

DISK="/dev/vdb"
MOUNTPOINT="/mnt/disk"

mkdir -p ${MOUNTPOINT}

if [ x"$FILESYSTEM" = x"zfs" ]; then
  ZFS_POOL_NAME=zfs-vdb

  sudo apt-get install -y zfsutils-linux
  sudo zpool create ${ZFS_POOL_NAME} ${DISK}

  sudo zfs set mountpoint=${MOUNTPOINT} ${ZFS_POOL_NAME}
else
  echo -e "n\np\n1\n\n\nw" | fdisk ${DISK}

  mkfs.${FILESYSTEM} ${DISK}1
  mkdir -p ${MOUNTPOINT}

  mount -t ${FILESYSTEM} ${DISK}1 ${MOUNTPOINT}
fi
