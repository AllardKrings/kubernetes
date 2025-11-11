kubectl delete -f nextcloud.yaml
kubectl delete -f nginx-config.yaml
kubectl apply -f nginx-config.yaml
kubectl apply -f nextcloud.yaml
