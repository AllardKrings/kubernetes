Installatie:
============
helm repo add postgres-operator-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator
helm install postgres-operator postgres-operator-charts/postgres-operator

helm repo add postgres-operator-ui-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator-ui
helm install postgres-operator-ui postgres-operator-ui-charts/postgres-operator-ui -f postgres-operator-values.yaml

Password:
---------

echo "Password: $(kubectl -n default get secret \ 
postgres.postgres-cluster-1.credentials.postgresql.acid.zalan.do -o \ 
jsonpath="{.data.password}" | base64 -d)"

External access:
----------------

exposen via loadbalancer!

Let op bij installatie UI wel de postgres-operator-values.yaml  meenemen i.v.m. URL!
b.v. appUrl: "http://pgzalando.alldcs.online:8081"
