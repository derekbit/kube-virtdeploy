#!/bin/bash

echo ">>> Installing stern"

STERN_VERSION=$1

wget https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64
mv stern_linux_amd64 /usr/local/bin/stern
chmod 755 /usr/local/bin/stern
