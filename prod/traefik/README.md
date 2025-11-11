1) traefik installeren via helmchart:
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
kubectl create namespace traefik

2) persistent storage aanmaken:

kubectl apply -f traefik-pvc.yaml

When enabling persistence for certificates, permissions on acme.json can be
lost when Traefik restarts. You can ensure correct permissions with an
initContainer. See https://github.com/traefik/traefik-helm-chart/blob/master/EXAMPLES.md#use-traefik-native-lets-encrypt-integration-without-cert-manager

3) Installeren

helm install traefik traefik/traefik -f values.yaml -n traefik

CHECK OF PORTFORWARDING VAN POORT 80 en 443 OP DE ROUTER NAAR DE LOADBALANCER GOED STAAT! 
HERSTART NA WIJZIGING DE KPN-ROUTER!

4) TLS verzwaren (tlsoption.yml is afkomstig van whoami-voorbeeld)

kubectl apply -f tlsoption.yaml 

7) Daschboard toegankelijk maken (dashboard.yaml is afkomstig van helm-documentatie van traefik zelf) 

kubectl apply -f ingressroute-dashboard.yaml - n traefik

#migreren:

kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml




