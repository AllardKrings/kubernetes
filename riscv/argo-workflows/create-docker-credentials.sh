kubectl create secret generic docker-creds \
  --from-literal=username=allardkrings@gmail.com \
  --from-literal=password='Kubernetes01@' \
      -n argo
