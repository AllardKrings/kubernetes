./rabbitmqadmin --host=rabbitmq-riscv.allarddcs.nl \
  --port=443 \
  --ssl \
  --username=guest \
  --password=guest \
  declare queue name=testqueue durable=true
