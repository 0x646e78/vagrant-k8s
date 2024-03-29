# Kubernetes VM labs

Provision a local kubernetes lab with Vagrant.

## pre-reqs

[Vagrant](https://www.vagrantup.com/) & Parallels, Virtual Box or VMWare Fusion.

## Starting the VMs

Choose your setup, for example to deploy kubernetes v1.19 with Docker & Calico on Ubuntu LTS:

```
cd v119-docker-calico-ubuntu2004
./install
```

Some labs require an additional step, which will be given in the output of the install.

Connect and see that pods are running:

```
vagrant ssh k8smaster
k get nodes
k get pods --all-namespaces
```

## Overview

I started this while preparing for the CKA exam. Since then I have expanded to include recent versions, and used this as a lab environment for the CKS curriculum. I try to maintain the prior versions for use in pentest labs and safe spaces to try things I encounter in prod, if you find any bugs or have a feature request please raise a github issue.

Currently these are all kubeadm created bare-bones clusters. No admission controllers or additional features have been installed aside from some basic tooling such as jq.

Various kubernetes versions, runtimes and CNI providers are available, the naming of the subfolders indicates the configuration.

Current options:

- Kubernetes 1.19, 1.20, 1.21
- Ubuntu 18.04, 20.04
- Calico network provider
- Docker or containerd runtime
- kubectl autocomplete and k alias
- Control Plane untainted by default

## Configuration

### Memory & CPU allocation

Memory and CPU allocation can be customised in `Vagrantfile`.
By default memory and CPU cores are:

|              | CPU Cores | Memory |
|:---|:---:|:---:|
|Control Plane | 3 | 6Gi |
|Worker        | 2 | 4Gi |

### Networking:

The pod network cidr is created as `172.16.10.0/24`. Update `provision-master.sh` to change this, such as 
if this is a routable network from your host machine.
