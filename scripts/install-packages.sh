#!/bin/bash

echo ">>> Installing packages"

BOOTSTRAPPER=$1

host_os()
{
  OS=`grep -E "^ID_LIKE=" /etc/os-release | cut -d '=' -f 2`
  if [[ -z "${OS}" ]]; then
    OS=`grep -E "^ID=" /etc/os-release | cut -d '=' -f 2`
  fi
  echo "$OS"
}

OS=`host_os`

case $OS in
"debian" | "ubuntu" )
  export DEBIAN_FRONTEND=noninteractive

  apt-get update -y
  apt-get install -y git vim curl jq build-essential openssh-server net-tools
  apt-get install -y open-iscsi nfs-common

  # Use --flannel-backend=wireguard in K3s
  apt-get install -y wireguard
  ;;
*"centos"* | *"fedora"* )
  #sed -i 's|vault.centos.org|mirror01.idc.hinet.net|g' /etc/yum.repos.d/CentOS-Linux-*

  #yum update -y
  yum install -y git vim curl jq wget openssh-clients openssh-server net-tools

  systemctl disable firewalld --now
  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  systemctl restart sshd

  yum install -y nfs-utils iscsi-initiator-utils
  yum install -y policycoreutils-python-utils container-selinux

  case $BOOTSTRAPPER in
  "k3s" )
    yum install -y https://github.com/k3s-io/k3s-selinux/releases/download/v1.1.stable.1/k3s-selinux-1.1-1.el8.noarch.rpm
    ;;
  "rke2" )
    yum install -y https://github.com/rancher/rke2-selinux/releases/download/v0.9.stable.1/rke2-selinux-0.9-1.el8.noarch.rpm
    ;;
  *)
    exit 1
  esac
  ;;
*)
  exit 1
  ;;
esac
