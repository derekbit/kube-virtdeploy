#!/bin/bash

echo ">>> Resize filesystem"

growpart /dev/vda 3
resize2fs /dev/vda3


mkdir /tmp/ramdisk
chmod 777 /tmp/ramdisk
mount -t tmpfs -o size=20G tmpfs /tmp/ramdisk/
