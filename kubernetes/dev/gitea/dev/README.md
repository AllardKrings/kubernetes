#Installatie via Helm:

helm repo add bitnami https://charts.bitnami
kubectl apply -f gitea-pvc.yaml
kubectl apply -f ingressrouteTCP-http.yaml
kubectl apply -f ingressrouteTCP-tls.yaml
kubectl apply -f ingressrouteTCP-ssh.yaml
helm install gitea bitnami/gitea -f values.yaml -n gitea

- er wordt via cert-manager een certificaat aangemaakt:


gitea.alldcs.nl-tls               kubernetes.io/tls
gitea-externaldb                  Opaque
gitea                             Opaque
sh.helm.release.v1.gitea.v1       helm.sh/release.v1

#repository koppelen:

https://gitea.alldcs.nl/allard/kubernetes DUS ZONDER .git!
user: allard
password: Gitea01@
project: default


#webhook definieren bij je repository:

http://el-gitea-listener.default.svc.cluster.local:8080
http://192.168.2.170:31234

en in app.ini:

[webhook]
ALLOWED_HOST_LIST=el-gitea-listener.default.svc.cluster.local 
#dus zonder http:// en :8080



