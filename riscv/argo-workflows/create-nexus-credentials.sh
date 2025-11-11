kubectl create secret generic nexus-credentials \
  --from-literal=username=admin \
  --from-literal=password='Nexus01@' \
      -n argo
