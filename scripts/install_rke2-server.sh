#!/bin/bash

echo ">>> Installing RKE2 server"

RKE2_VERSION=$1
RKE2_TOKEN=$2
KUBELET_LOG_LEVEL=$3
IP=$4

echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> /root/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> /root/.bashrc
echo "export CRI_CONFIG_FILE=/var/lib/rancher/rke2/agent/etc/crictl.yaml" >> /root/.bashrc

mkdir -p /etc/rancher/rke2

cat <<EOF > /etc/rancher/rke2/config.yaml
token: ${RKE2_TOKEN}
node-external-ip: ${IP}
node-ip: ${IP}
kubelet-arg: "v=${KUBELET_LOG_LEVEL}"
EOF

export INSTALL_RKE2_VERSION=${RKE2_VERSION}

curl -sfL https://get.rke2.io | sh -

systemctl enable rke2-server.service
systemctl start rke2-server.service
