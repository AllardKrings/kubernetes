echo user: $(microk8s kubectl get secret cluster1-pguser-cluster1 -o jsonpath="{.data.user}" | base64 -d)
echo password: $(microk8s kubectl get secret cluster1-pguser-cluster1 -o jsonpath="{.data.password}" | base64 -d)
