#!/usr/bin/env bash

vagrant up
token=$(vagrant ssh k8smaster -c "kubeadm token create --print-join-command 2>/dev/null" 2>/dev/null)
join="sudo $token"
#echo $join
#vagrant ssh k8sworker1 -c '${join}'
echo "***COMPLETE***"
echo "Join the worker to the master with:"
echo "vagrant ssh k8sworker1"
echo $join
echo "Then connect with:"
echo " vagrant ssh k8smaster"
