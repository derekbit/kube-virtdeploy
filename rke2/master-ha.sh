#!/bin/bash

VERSION="v1.23.6+rke2r2"
TOKEN="helloworld"
NODE_IP="10.8.59.3"
URL="10.8.59.1"


########### Main Logic #############
export INSTALL_RKE2_VERSION=${VERSION}
export RKE2_TOKEN=${TOKEN}
export RKE2_URL=https://${URL}:9345

mkdir -p /etc/rancher/rke2

cat <<EOF > /etc/rancher/rke2/config.yaml
server: ${RKE2_URL}
token: ${RKE2_TOKEN}
node-external-ip: ${NODE_IP}
node-ip: ${NODE_IP}
resolv-conf: "/etc/resolv.conf"
EOF

curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
