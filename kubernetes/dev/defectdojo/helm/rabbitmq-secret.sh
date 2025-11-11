microk8s kubectl -n defectdojo create secret generic defectdojo-rabbitmq-specific \
--from-literal=rabbitmq-password=mqrabbitmq \
--from-literal=rabbitmq-erlang-cookie=rabbitmqrabbitmqrabbitmqrabbitmq -n defectdojo
