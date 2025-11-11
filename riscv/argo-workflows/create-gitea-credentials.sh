kubectl create secret generic gitea-creds \
    --from-literal=username=allard \
    --from-literal=password='Gitea01@' \
      -n argo
