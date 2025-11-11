microk8s helm install postgres-operator postgres-operator-charts/postgres-operator
microk8s helm install postgres-operator-ui postgres-operator-ui-charts/postgres-operator-ui -f postgres-operator-ui-values.yaml
