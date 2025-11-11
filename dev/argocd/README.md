#Installatie:	

kubectl create ns argocd
helm install argocd -f values.yaml bitnami/argo-cd -n argocd
ingressroutes:
- door het PROD-cluster loopt een ingressrouteTCP met tls: passtrough: true. 
- in het DEV-cluster is alleen de  tls ingressroute nodig

de helmchart:
- maakt Tls-certificaat aan
- de helm-chart maakt secret aan met user: admin, password: Argocd01@

#password opvragen:

echo "Password: $(kubectl -n default get secret argocd-secret -o 
jsonpath="{.data.clearPassword}" | base64 -d)"

#gitea repository koppelen:

Checken of de repository in git aanwezig is.

project: default
https://gitea-dev.allarddcs.nl/AllardDCS/dev/olproperties (ZONDER.git!!!)
user: allard
password: Gitea01@

#applicatie toevoegen:

repository invullen
pad toevoegen (olproperties)

#task argocd-sync-and-wait installeren:

kubectl apply -f argocd-task-sync-and-wait.yaml

    #testen kan met:
kubectl apply -f argocd-pipeline.yaml 
kubectl create -f  argocd-pipeline-run.yaml

