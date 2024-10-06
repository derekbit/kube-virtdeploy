#!/bin/bash

echo ">>> Installing Kubernetes tools ..."

HELM_VERSION=$1
K9S_VERSION=$2

helm_install()
{
  wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz
  tar zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz
  sudo mv linux-amd64/helm /usr/local/bin/
}

k9s_install()
{
  curl -sfL https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz | tar zxvf - -C /usr/local/bin
  chmod 755 /usr/local/bin/k9s
}

#helm_install
#k9s_install

