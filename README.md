# vagrant-k8sS

Provision a 1 Master, 1 Worker kubernetes lab with Vagrant.

- Kubernetes 1.18
- Ubuntu base
- Vagrant, currently with VMware Fusion
- Master untainted

```
vagrant up
vagrant ssh k8smaster
k get nodes --all-namespaces
```

Note: Creates the pod network as 172.16.10.0/24, update provision-master.sh 
if this is a routable network from your host machine.
