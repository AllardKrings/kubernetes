microk8s kubectl create secret generic argocd-env-secret \
    --from-literal=ARGOCD_USERNAME=admin \
    --from-literal=ARGOCD_PASSWORD='Argocd01@'
