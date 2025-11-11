kubectl patch svc nodeport -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'
