#!/bin/bash
rm -rf certs
rm -rf my-safe-directory
mkdir certs
mkdir my-safe-directory
cockroach cert create-ca --certs-dir=certs --ca-key=my-safe-directory/ca.key
cockroach cert create-client root --certs-dir=certs --ca-key=my-safe-directory/ca.key
#microk8s kubectl create ns cockroachdb
microk8s kubectl create secret generic cockroachdb.client.root --from-file=certs
cockroach cert create-node --certs-dir=certs --ca-key=my-safe-directory/ca.key localhost 127.0.0.1 cockroachdb-public cockroachdb-public.default cockroachdb-public.default.svc.cluster.local *.cockroachdb *.cockroachdb.default *.cockroachdb.default.svc.cluster.local
microk8s kubectl create secret generic cockroachdb.node --from-file=certs
microk8s kubectl create -f cockroachdb.yaml
microk8s kubectl get pod
microk8s kubectl exec -it cockroachdb-0 \
-- /cockroach/cockroach init \
--certs-dir=/cockroach/cockroach-certs
