#Installation:

#apply the CRD:

kubectl apply -f https://raw.githubusercontent.com/cockroachdb/cockroach-operator/v2.14.0/install/crds.yaml

#install cockroachdb:

kubectl apply -f cockroachdb.yaml

#Initialiseren cluster:

kubectl exec -it cockroachdb-0 \
-- /cockroach/cockroach init \
--certs-dir=/cockroach/cockroach-certs

#Inloggen client:

kubectl exec -it cockroachdb-client-secure \
-- ./cockroach sql \
--certs-dir=/cockroach-certs \
--host=cockroachdb-public

#Gebruiker aanmaken:

CREATE USER roach WITH PASSWORD 'Cockroach01@';
