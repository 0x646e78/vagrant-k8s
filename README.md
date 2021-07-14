# Kubernetes VM Lab, provisioned by Vagrant

Provision a 1 Master, 1 Worker Kubernetes lab with Vagrant.

- Kubernetes 1.19
- Ubuntu LTS base (20.04)
- Calico network provider
- Master untainted
- kubectl autocomplete and k alias
- Currently tested with VMware Fusion, Virtualbox and Parallels

Run:

```
vagrant up
```

Then join the worker to the master:

```
vagrant ssh k8smaster -c "kubeadm token create --print-join-command 2>/dev/null" 2>/dev/null
vagrant ssh k8sworker1 -c "sudo kubeadm <paste output from above line>"
```

Connect and see that pods are running:

```
vagrant ssh k8smaster
k get nodes --all-namespaces
```

## Configuration

Memory and CPU core allocation can be customised in  `Vagrantfile`.
By default memory and CPU cores are as such:

### Master:

CPU Cores: 3

Memory: 6Gi

### Worker:

CPU Cores: 2

Memory: 4Gi
 

### Networking:

The pod network cidr is created as 172.16.10.0/24. Update provision-master.sh 
if this is a routable network from your host machine.

[parallels-bug]: https://github.com/Parallels/vagrant-parallels/issues/357
