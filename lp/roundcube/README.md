helm repo add mlohr https://helm-charts.mlohr.com/
helm repo update

helm install roundcube mlohr/roundcube -f values.yaml -n mail
