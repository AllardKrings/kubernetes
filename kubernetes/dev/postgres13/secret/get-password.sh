echo User    : $(microk8s kubectl get secret postgres -o jsonpath="{.data.POSTGRES_USER}" | base64 -d)
echo Password: $(microk8s kubectl get secret postgres -o jsonpath="{.data.POSTGRES_PASSWORD}" | base64 -d)
