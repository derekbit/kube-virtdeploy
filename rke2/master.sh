#!/bin/bash

VERSION="v1.23.6+rke2r2"
TOKEN="helloworld"
NODE_IP="10.79.30.131"

########### Main Logic #############
export INSTALL_RKE2_VERSION=${VERSION}
export RKE2_TOKEN=${TOKEN}

echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> /root/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> /root/.bashrc
echo "export CRI_CONFIG_FILE=/var/lib/rancher/rke2/agent/etc/crictl.yaml" >> /root/.bashrc

mkdir -p /etc/rancher/rke2

cat <<EOF > /etc/rancher/rke2/config.yaml
token: ${RKE2_TOKEN}
node-external-ip: ${NODE_IP}
node-ip: ${NODE_IP}
resolv-conf: "/etc/resolv.conf"
EOF

curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
