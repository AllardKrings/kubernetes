#!/bin/bash
microk8s 
kubectl apply --filename 
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
microk8s kubectl apply -f 
https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml
microk8s kubectl apply -f ingressroute-tls.yaml
microk8s config > admin.conf
sudo mv admin.conf /etc/kubernetes/
