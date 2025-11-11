microk8s kubectl delete secret minio-creds -n postgres
microk8s kubectl create secret generic minio-creds \
  --from-literal=MINIO_ACCESS_KEY=Gudh6fKAlGv5PFWxLrCS \
  --from-literal=MINIO_SECRET_KEY=L2CxDKJAvXS2h0KyWWX3fu9twiVIzR1tZpoEYINl \
  --from-literal=REGION=us-east \
  -n postgres
