# Kubernetes VM labs

Provision a local Kubernetes lab with Vagrant.

I originally created this while preparing for the CKA exam. Since then I have expanded to include more recent versions, including a lab for the CKS curriculum. Currently these are all kubeadm created bare-bones clusters. No admission controllers or additional features have been installed aside from some basic tooling such as jq.

Various kubernetes versions, runtimes and CNI providers are available, the naming of the subfolders indicates what is available.

Featuring:

- Kubernetes 1.19, 1.20, 1.21
- Ubuntu 18.04, 20.04
- Calico network provider
- Docker or containerd runtime
- kubectl autocomplete and k alias
- Control Plane untainted
- Currently tested with VMware Fusion, Virtualbox and Parallels

## Starting the VMs

Choose your setup, for example to deploy Kubernetes v1.19 with Docker & Calico on Ubuntu LTS:

```
cd v119-docker-calico-ubuntu2004
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
k get nodes
k get pods --all-namespaces
```

## Memory & CPU allocation

Memory and CPU allocation can be customised in `Vagrantfile`.
By default memory and CPU cores are as such:

### Master:

CPU Cores: 3

Memory: 6Gi

### Worker:

CPU Cores: 2

Memory: 4Gi
 

## Networking:

The pod network cidr is created as 172.16.10.0/24. Update provision-master.sh 
if this is a routable network from your host machine.
