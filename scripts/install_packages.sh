#!/bin/bash

echo ">>> Installing packages"

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y git vim curl build-essential openssh-server

apt-get install -y jq open-iscsi nfs-common
