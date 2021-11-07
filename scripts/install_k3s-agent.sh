#!/bin/bash

echo ">>> Installing K3s agent"

K3S_VERSION=$1
K3S_TOKEN=$2
K3S_URL=$3
KUBELET_LOG_LEVEL=$4

export INSTALL_K3S_VERSION=${K3S_VERSION}
export K3S_TOKEN=${K3S_TOKEN}
export K3S_URL=${K3S_URL}
export INSTALL_K3S_EXEC="--kubelet-arg v=${KUBELET_LOG_LEVEL}"

curl -sfL https://get.k3s.io | sh -
