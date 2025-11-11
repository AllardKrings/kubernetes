kubectl create secret tls nexus-cert \
  --cert=allarddcs.nl.cert \
  --key=allarddcs.nl.key \
  -n nexus
