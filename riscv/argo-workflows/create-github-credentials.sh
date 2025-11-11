kubectl create secret generic github-creds \
    --from-literal=username=allardkrings@gmail.com \
    --from-literal=password='Kubernetes01@' \
      -n argo
