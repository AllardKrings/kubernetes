#ruw materiaal voor mocht het beschikbaar komen op riscv

INSTALLATIE:

kubectl apply -f grafana-pv.yaml

kubectl apply -f grafana-pvc.yaml

kubectl create -f grafana-datasource-config.yaml

kubectl create -f deployment.yaml

kubectl create -f service.yaml



# kubernetes-grafana

Read about the grafana implementation on Kubernetes here https://devopscube.com/setup-grafana-kubernetes/
