#!/bin/bash

echo ">>> Installing K8s completion"

echo "source <(kubectl completion bash)" >> /root/.bashrc
echo "alias k='kubectl'" >> /root/.bashrc
echo "complete -F __start_kubectl k" >> /root/.bashrc
echo "alias kl='kubectl -n longhorn-system'" >> /root/.bashrc
echo "complete -F __start_kubectl kl" >> /root/.bashrc
