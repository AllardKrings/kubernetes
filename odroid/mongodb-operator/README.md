INSTALLATIE:
============

#als nog niet gedaan:

kubectl create ns mongodb-operator
kubectl create ns mongodb

#als nog niet gedaan:

helm repo add mongodb https://mongodb.github.io/helm-charts
helm repo update

#installatie operator:

helm install community-operator mongodb/community-operator --namespace mongodb-operator --set operator.watchNamespace="*"

