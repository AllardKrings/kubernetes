./rabbitmqadmin \
  --host=rabbitmq-riscv.allarddcs.nl \
  --port=443 \
  --ssl \
  --username=guest \
  --password=guest \
  get queue=testqueue count=1 \
  --arguments='{"requeue":false}'
