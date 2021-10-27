#!/usr/bin/env bash

swapoff -a
sed -i 's/^.*swap.*$//g' /etc/fstab

apt-get update
apt-get install -y vim apt-transport-https curl ca-certificates software-properties-common gnupg2 nfs-common

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

echo 'deb https://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

apt-get update
apt-get install -y \
  kubelet=1.20.1-00 kubeadm=1.20.1-00 kubectl=1.20.1-00 \
  containerd.io

apt-mark hold kubelet kubeadm kubectl

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

systemctl daemon-reload
systemctl restart containerd
systemctl restart kubelet
kubeadm config images pull
