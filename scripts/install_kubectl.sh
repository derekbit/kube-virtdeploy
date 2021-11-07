#!/bin/bash

echo ">>> Installing kubectl"

KUBECTL_VERSION=$1

wget https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -P /usr/local/bin
chmod 755 /usr/local/bin/kubectl
