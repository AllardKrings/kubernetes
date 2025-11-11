#Installatie

#eigen namespace:

kubectl create ns quay

#Redis:

is al geinstalleeerd op de odroid, 192.168.2.239:6379 password: Redis01@ 

#Postgress13:

is al geinstalleerd op de odroid. 192.168.2.235:5432 password: quay

installeren van extensies:
- inloggen incontainer:
	kubectl exec -it postgres13-0 -n postgres
- inloggen op dadabase quay:
	psql -U quay --dbname=quay 
- sql uitvoeren:
	create extension if not exists pg_trgm;
	
#quay
kubectl apply -f quay.yaml -n quay

#SSL configureren:

Mounten van een certificaat is helaas niet mogelijk omdat dit dezelfde directory in de container 
is waar je ook al config.yaml mount vanaf de nfs-share.

daarom: 

- eerst op pisvrwsv01 letsencrypt-certificaat laten maken via certmanager:

kubectl apply -f certificate.yaml

Er ontstaat dan een secret: "quay.alldcs.nl-tls"

dan de ssl-cert en ssl.key extraheren:

kubectl get secret quay.alldcs.nl-tls -o json -o=jsonpath="{.data.tls\.crt}" | base64 -d > ssl.cert
kubectl get secret quay.alldcs.nl-tls -o json -o=jsonpath="{.data.tls\.key}" | base64 -d > ssl.key

Vervolgens deze twee bestandjes kopieren naar /mnt/nfs-share/quay/conf op de NFS-server.
NIET VERGETEN ZE LEESBAAR TE MAKEN: chmod 777....

#verdere configuratie:

stop quay:
	kubectl delete -f quay.yaml

start quay in config mode:
	kubectl apply -f quay-config.yaml

op een of andere manier werkt de ingressroute nu niet meer, daarom moet je nodeport 
gebruiken:

ga naar: 
	localhost:<nodeport>

	LET OP: dit moet!! LOCALHOST zijn.
log in met quay config enhet password uit de yamlfile: config01
configureer quay
download de config.yaml (die komt in /home/ubuntu/Downloads
untar de config.yaml 
	tar -zxf 
kopieer de config.yaml naar de /mnt/nfs_share/quay/conf directory
start de gewone quay weer op.
	kubectl apply -f quay.yaml




#autorisaties

je kunt FEATURE_USER_CREATION: true zetten in de config.yaml en dan gebruiker opvoeren. 
vervolgens  met pgadmin voor dit account "verified" op "true" zetten (via mail werkt nog niet). 

Deze gebruiker kun je dan in de config.yaml bij SUPER_USER opvoeren. 
Dan quay opnieuw opstarten en je bent administrator! 

#integratie met Clair:

Quay starten in config  mode:

kubectl run --rm -it --name quay_config -p 8080:8080 \
    -v /home/ubuntu:/conf/stack \
    quay.io/projectquay/quay:v3.10.0 config Quay01@@
