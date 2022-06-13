#!/bin/bash

VERSION="v1.23.6+k3s1"
TOKEN="helloworld"
NODE_IP="10.76.15.1"
KUBELET_LOG_LEVEL="2"

export INSTALL_K3S_VERSION=${VERSION}
export K3S_TOKEN=${TOKEN}

#export INSTALL_K3S_EXEC="server --kubelet-arg v=${KUBELET_LOG_LEVEL} --resolv-conf /etc/resolv.conf"
export INSTALL_K3S_EXEC="server --resolv-conf /etc/resolv.conf"

echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /root/.bashrc
mkdir -p /etc/rancher/k3s
curl -sfL https://get.k3s.io | sh -
