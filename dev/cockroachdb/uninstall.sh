#!/bin/bash
microk8s kubectl delete -f cockroachdb.yaml
microk8s kubectl delete pvc datadir-cockroachdb-0 -n cockroachdb
microk8s kubectl delete pvc datadir-cockroachdb-1 -n cockroachdb
microk8s kubectl delete pvc datadir-cockroachdb-2 -n cockroachdb
microk8s kubectl delete secret cockroachdb.node -n cockroachdb
microk8s kubectl delete secret cockroachdb.client.root -n cockroachdb
microk8s kubectl delete ns cockroachdb
rm -rf certs
rm -rf my-safe-directory
