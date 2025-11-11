microk8s kubectl -n defectdojo create secret generic defectdojo-postgresql-specific \
--from-literal=postgresql-password=defectdojo \
--from-literal=postgresql-postgres-password=defectdojo -n defectdojo
