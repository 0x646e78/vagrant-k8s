#!/bin/bash

kubeadm init --control-plane-endpoint=k8smaster --upload-certs --pod-network-cidr=172.16.10.0/24
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config
su vagrant -c 'kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml'
su vagrant -c 'kubectl taint nodes --all node-role.kubernetes.io/master-'
su vagrant -c 'echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc'
echo 'alias k=kubectl' >> /home/vagrant/.bashrc
echo 'complete -F __start_kubectl k' >> /home/vagrant/.bashrc
