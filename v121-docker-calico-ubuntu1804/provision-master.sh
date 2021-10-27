#!/bin/bash

kubeadm init --kubernetes-version=1.21.1 --control-plane-endpoint=k8smaster --upload-certs --pod-network-cidr=172.16.10.0/24

mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config
#su vagrant -c 'kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml'
#su vagrant -c 'wget https://docs.projectcalico.org/manifests/custom-resources.yaml'
#su vagrant -c 'sed -i "s,192.168.0.0/16,172.16.10.0/24," custom-resources.yaml'
#su vagrant -c 'kubectl apply -f custom-resources.yaml'
su vagrant -c 'curl https://docs.projectcalico.org/manifests/calico.yaml -O'
su vagrant -c 'kubectl apply -f calico.yaml'
su vagrant -c 'kubectl taint nodes --all node-role.kubernetes.io/master-'
su vagrant -c 'echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc'
echo 'alias k=kubectl' >> /home/vagrant/.bashrc
echo 'complete -F __start_kubectl k' >> /home/vagrant/.bashrc
