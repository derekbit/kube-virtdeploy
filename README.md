# Kube-VirtDeploy

Create a kubernetes cluster using KVM/QEMU and RKE2|K3s in minutes.

## Usage
### Configure
Edit the config.yaml according your configuration.

### Bootstrap a cluster
```
$ ./kube-virtdeploy start
```

### Destrop a cluster
```
$ ./kube-virtdeploy stop
```

### Power up a node
```
$ ./kube-virtdeploy power-up <name>
```

### Power down a node
```
$ ./kube-virtdeploy power-down <name> --force
```

Or, power down a node forcely
```
$ ./kube-virtdeploy power-down <name> --force
```

### Issues Notes
- [Debugging DNS Resolution](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#known-issues)

- [Kubernetes: Pods Can't Resolve Hostnames](https://stackoverflow.com/questions/45805483/kubernetes-pods-cant-resolve-hostnames)
  Quick solution: restart coreDNS by `kubectl -n kube-system rollout restart deployment coredns`
