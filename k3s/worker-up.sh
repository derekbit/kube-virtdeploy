#!/bin/bash

VERSION="v1.23.6+k3s1"
TOKEN="helloworld"
NODE_IP="10.74.48.133"
URL="https://10.74.48.131"
KUBELET_LOG_LEVEL="2"

export INSTALL_K3S_VERSION=${VERSION}
export K3S_TOKEN=${TOKEN}
export K3S_URL=${URL}:6443
export INSTALL_K3S_EXEC="--kubelet-arg v=${KUBELET_LOG_LEVEL} --resolv-conf /etc/resolv.conf"

curl -sfL https://get.k3s.io | sh -
