microk8s kubectl apply  -f configmap.yaml
microk8s kubectl rollout restart deploy/backstage -n backstage
microk8s kubectl get pod -n backstage
