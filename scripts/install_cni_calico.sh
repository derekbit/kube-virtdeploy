#!/bin/bash

echo ">>> Install CNI Calico"

# Referece: https://docs.projectcalico.org/getting-started/kubernetes/k3s/quickstart

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
