#!/bin/bash

echo ">>> Installing K9s"

K9S_VERSION=$1

curl -sfL https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_x86_64.tar.gz | tar zxvf - -C /usr/local/bin
chmod 755 /usr/local/bin/k9s
