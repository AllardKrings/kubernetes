microk8s kubectl delete -f backstage.yaml
microk8s kubectl apply  -f configmap.yaml
microk8s kubectl apply  -f backstage.yaml
