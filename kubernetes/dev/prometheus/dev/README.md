microk8s enable observability

kubectl apply -f ingressroute-tls.yaml

Let op: host-access moet enabled zijn op alle nodes, anders kan de autorisatie 
voor het uitlezen van de node niet worden aangebracht.

Let op: ingressroute-tls.yaml zit in namespace "observability"

Grafana:

user: admin
password: prom-operator
