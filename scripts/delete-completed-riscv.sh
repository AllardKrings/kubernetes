kubectl delete pod -A --field-selector=status.phase==Succeeded
kubectl delete pod -A --field-selector=status.phase==Failed
