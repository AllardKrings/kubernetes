#deploy operator
kubectl apply --server-side -f \
https://raw.githubusercontent.com/percona/percona-postgresql-operator/main/deploy/bundle.yaml
#deploy cluster
kubectl apply 
-f https://raw.githubusercontent.com/percona/percona-postgresql-operator/main/deploy/cr.yaml
