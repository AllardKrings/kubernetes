cd ~/
microk8s kubectl delete secret registry-credentials
microk8s kubectl create secret generic registry-credentials --from-file=.dockerconfigjson=/home/ubuntu/.docker/config.json --type=kubernetes.io/dockerconfigjson

