./rabbitmqadmin --host=rabbitmq-riscv.allarddcs.nl \
  --port=443 \
  --ssl \
  --username=guest \
  --password=guest \
  publish routing_key=testqueue payload="Hello from CLI"
