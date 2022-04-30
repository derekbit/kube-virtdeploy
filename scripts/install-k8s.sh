#!/bin/bash

BOOTSTRAPPER=$1
VERSION=$2
ROLE=$3
TOKEN=$4
NODE_IP=$5
URL=$6
KUBELET_LOG_LEVEL=$7

case $BOOTSTRAPPER in
"k3s" )
  export INSTALL_K3S_VERSION=${VERSION}
  export K3S_TOKEN=${TOKEN}

  case $ROLE in
  "server" )
    #export INSTALL_K3S_EXEC="server --node-taint node-role.kubernetes.io/master=true:NoExecute --node-taint node-role.kubernetes.io/master=true:NoSchedule --flannel-backend=wireguard --kubelet-arg v=${KUBELET_LOG_LEVEL} --resolv-conf /etc/resolv.conf"
    export INSTALL_K3S_EXEC="server --node-taint node-role.kubernetes.io/master=true:NoExecute --node-taint node-role.kubernetes.io/master=true:NoSchedule --kubelet-arg v=${KUBELET_LOG_LEVEL} --resolv-conf /etc/resolv.conf"

    echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /root/.bashrc
    mkdir -p /etc/rancher/k3s
    curl -sfL https://get.k3s.io | sh - 
    ;;
  "worker" )
    export K3S_URL=${URL}:6443
    export INSTALL_K3S_EXEC="--kubelet-arg v=${KUBELET_LOG_LEVEL} --resolv-conf /etc/resolv.conf"
    curl -sfL https://get.k3s.io | sh - 
    ;;
  *)
    exit 1
    ;;
  esac
  ;;
"rke2" )
  export INSTALL_RKE2_VERSION=${VERSION}
  export RKE2_TOKEN=${TOKEN}

  case $ROLE in
  "server" )
    echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> /root/.bashrc
    echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> /root/.bashrc
    echo "export CRI_CONFIG_FILE=/var/lib/rancher/rke2/agent/etc/crictl.yaml" >> /root/.bashrc

    mkdir -p /etc/rancher/rke2

    cat <<EOF > /etc/rancher/rke2/config.yaml
token: ${RKE2_TOKEN}
node-external-ip: ${NODE_IP}
node-ip: ${NODE_IP}
kubelet-arg: "v=${KUBELET_LOG_LEVEL}"
resolv-conf: "/etc/resolv.conf"
EOF

    curl -sfL https://get.rke2.io | sh -
    systemctl enable rke2-server.service
    systemctl start rke2-server.service
    ;;
  "worker" )
    export RKE2_URL=${URL}:9345
    export INSTALL_RKE2_EXEC="--kubelet-arg v=${KUBELET_LOG_LEVEL}"
    export INSTALL_RKE2_TYPE=agent

    mkdir -p /etc/rancher/rke2

    cat <<EOF > /etc/rancher/rke2/config.yaml
server: ${RKE2_URL}
token: ${RKE2_TOKEN}
node-external-ip: ${NODE_IP}
node-ip: ${NODE_IP}
kubelet-arg: "v=${KUBELET_LOG_LEVEL}"
resolv-conf: "/etc/resolv.conf"
EOF

    curl -sfL https://get.rke2.io | sh -
    systemctl enable rke2-agent.service
    systemctl start rke2-agent.service
    ;;
  *)
    exit 1
    ;;
  esac
  ;;
*)
  exit 1
  ;;
esac

echo "source <(kubectl completion bash)" >> /root/.bashrc
echo "alias k='kubectl'" >> /root/.bashrc
echo "complete -F __start_kubectl k" >> /root/.bashrc
echo "alias kl='kubectl -n longhorn-system'" >> /root/.bashrc
echo "complete -F __start_kubectl kl" >> /root/.bashrc
