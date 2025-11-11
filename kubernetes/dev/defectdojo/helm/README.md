#Installatie

https://epam.github.io/edp-install/operator-guide/install-defectdojo/


kubectl create namespace defectdojo

helm repo add defectdojo 'https://raw.githubusercontent.com/DefectDojo/django-DefectDojo/helm-charts'
helm repo update

Create PostgreSQL admin secret:


kubectl -n defectdojo create secret generic defectdojo-postgresql-specific \
--from-literal=postgresql-password=defectdojodefect \
--from-literal=postgresql-postgres-password=defectdojodefect

Create Rabbitmq admin secret:


kubectl -n defectdojo create secret generic defectdojo-rabbitmq-specific \
--from-literal=rabbitmq-password=defectdojo \
--from-literal=rabbitmq-erlang-cookie=defectdojodefectdojodefectdojojo

Create DefectDojo admin secret:


kubectl -n defectdojo create secret generic defectdojo \
--from-literal=DD_ADMIN_PASSWORD=defectdojodefectdojojo \
--from-literal=DD_SECRET_KEY=defectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefecdojojo \
--from-literal=DD_CREDENTIAL_AES_256_KEY=defectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefectdojodefecdojojo \
--from-literal=METRICS_HTTP_AUTH_PASSWORD=defectdojodefectdojodefectdojojo

Install DefectDojo v.2.22.4 using defectdojo/defectdojo Helm chart v.1.6.69:


helm upgrade --install \
defectdojo \
--version 1.6.69 \
defectdojo/defectdojo \
--namespace defectdojo \
--values values.yaml
