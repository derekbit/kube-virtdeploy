#!/bin/bash

echo ">>> Installing K3s server"

K3S_VERSION=$1
K3S_TOKEN=$2
KUBELET_LOG_LEVEL=$3

export INSTALL_K3S_VERSION=${K3S_VERSION}
export K3S_TOKEN=${K3S_TOKEN}
#export INSTALL_K3S_EXEC="server --flannel-backend=wireguard --kubelet-arg v=${KUBELET_LOG_LEVEL} --resolv-conf /etc/resolv.conf"
export INSTALL_K3S_EXEC="server --node-taint node-role.kubernetes.io/master=true:NoExecute --node-taint node-role.kubernetes.io/master=true:NoSchedule --flannel-backend=wireguard --kubelet-arg v=${KUBELET_LOG_LEVEL} --resolv-conf /etc/resolv.conf"


mkdir -p /etc/rancher/k3s
curl -sfL https://get.k3s.io | sh -

echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /root/.bashrc
