#!/bin/bash

echo ">>> Installing Docker"

#export DEBIAN_FRONTEND=noninteractive

#apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    
#apt-get update -y
#apt-get install -y docker-ce docker-ce-cli containerd.io

wget https://download.docker.com/linux/static/stable/x86_64/docker-18.09.9.tgz
tar xzvf docker-18.09.9.tgz
sudo cp docker/* /usr/bin/
sudo dockerd &
