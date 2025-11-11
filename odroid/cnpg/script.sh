CLUSTER_NAME=postgres13
NAMESPACE=postgres

PRIMARY=$(kubectl get cluster -n "$NAMESPACE" "$CLUSTER_NAME" -o jsonpath='{.status.currentPrimary}')
for pvc in $(kubectl get pvc -n "$NAMESPACE" -l"cnpg.io/cluster=$CLUSTER_NAME" -o name); do 
  ROLE=$([ "$pvc" = "persistentvolumeclaim/$PRIMARY" ] && echo primary || echo replica)
  kubectl label -n "$NAMESPACE" "$pvc" --overwrite "cnpg.io/instanceRole=$ROLE" "role=$ROLE"
done
kubectl delete pod -n "$NAMESPACE" -l "cnpg.io/cluster=$CLUSTER_NAME"
