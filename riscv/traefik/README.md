#Installatie:

Gewoon K3S installeren, daar zit stadaard traefik 2 in.

Deze traefik is geinstalleerd via de in K3S ingebouwde helm.

Test: kubectl get svc -n kube-system: nu zie je alleen poort 80 en poort 443.

#versie traefik:

kubectl exec -it traefik-765df5f764-br4rs -n kube-system -- traefik version

geeft:

Version:      2.10.3
Codename:     saintmarcelin
Go version:   go1.20.6
Built:        2023-07-19T09:18:04Z
OS/Arch:      linux/riscv64

#dashboard enablen

kubectl apply -f traefik-custom-conf.yaml

(Dit is een helm-configuratie die de via helm geinstalleerde traefik aanpast).

K3S stoppen en starten. Het duurt even voordat de traefik-service op beide nodes weer in de lucht is.

Test: kubectl get svc -n kube-system: nu zie je ook poort 9000 voor het dashboard opduiken

Het traefik-dashboard is nu via nodeport te benaderen.

De ingressroutes werken echter nog niet en verschijnen ook nog niet op het dashboard

Als je in de logging van de traefik-pod kijkt ziet je ook dat er foutmeldingen ontstaan 
dat objecten niet gevonden worden.

#time-out vergroten (als die bijvoorbeeld optreden bij pushen van images naar nexus) 
KUBE_EDITOR=nano kubectl edit deploy traefik -n kube-system

dan de volgende args toevoegen:

 	- --entryPoints.web.transport.respondingTimeouts.readTimeout=600s
	- --entryPoints.websecure.transport.respondingTimeouts.readTimeout=600s

en dan traefik herstarten:

	kubectl rollout status deploy traefik -n kube-system


#verdere stappen: 

migreer van traefik.containo.us naar traefik.io:

kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

pas autorisaties aan:

kubectl apply -f rbac.yaml
kubectl apply -f clusterrolbinding-admin.yaml


#Achtergrondinfo:

In v2.10, the Kubernetes CRDs API Group:  'traefik.containo.us' is deprecated, 
and its support will end starting with Traefik v3. 

Please use the API Group traefik.io instead.

As the Kubernetes CRD provider still works with both API Versions 
(traefik.io/v1alpha1 and traefik.containo.us/v1alpha1), 
it means that for the same kind, namespace and name, 
the provider will only keep the traefik.io/v1alpha1 resource.

In addition, the Kubernetes CRDs API Version traefik.io/v1alpha1 
will not be supported in Traefik v3 itself.

Please note that it is a requirement to update the CRDs and the RBAC in the cluster before upgrading Traefik. To do so, please apply the required CRDs and RBAC manifests for v2.10:

kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

