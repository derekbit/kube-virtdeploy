#!/bin/bash

BOOTSTRAPPER=$1
VERSION=$2
NOTE_NAME=$3
ROLE=$4
TOKEN=$5
NODE_IP=$6
URL=$7
KUBELET_LOG_LEVEL=$8

echo "Debug ++++++++++++ NODE=${NODE_IP}"

install_krew()
{
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew

  export PATH=${KREW_ROOT:-$HOME/.krew}/bin:$PATH
}

echo "BOOTSTRAPPER: $BOOTSTRAPPER"
echo "ROLE: $ROLE"

    echo "Debug ============> ${NODE_IP}"

