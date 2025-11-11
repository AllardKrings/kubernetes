echo User: $(microk8s kubectl get secret postgres.postgres-cluster-2.credentials.postgresql.acid.zalan.do  -o jsonpath="{.data.username}" | base64 -d)
echo Password: $(microk8s kubectl get secret postgres.postgres-cluster-2.credentials.postgresql.acid.zalan.do  -o jsonpath="{.data.password}" | base64 -d)
