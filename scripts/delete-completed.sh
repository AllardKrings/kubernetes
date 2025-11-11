microk8s kubectl delete pod -A --field-selector=status.phase==Succeeded
microk8s kubectl delete pod -A --field-selector=status.phase==Failed
