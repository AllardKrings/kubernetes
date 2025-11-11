#!/bin/bash
cd ~/containers/kubernetes
echo ""
echo "installeren algemene zaken:"
echo ""
microk8s enable rbac
microk8s enable ingress
microk8s enable host-access
microk8s enable community
microk8s enable metallb:192.168.2.181-192.168.2.190
microk8s enable cert-manager
microk8s kubectl apply -f kubernetes/cert-manager/cluster-issuer.yaml
echo ""
echo "installeren traefik:"
echo ""
microk8s kubectl create namespace traefik
microk8s helm install traefik traefik/traefik -f traefik/helm/values.yaml -n traefik
microk8s kubectl apply -f traefik/helm/tlsoption.yaml 
microk8s kubectl apply -f traefik/helm/dev/ingressroute-dashboard.yaml
echo ""
echo "installeren kubernetes dashboard:"
echo ""
microk8s enable dashboard
microk8s kubectl apply -f kubernetes/dashboard/serviceaccount.yaml
microk8s kubectl apply -f kubernetes/dashboard/clusterrolebinding.yaml
microk8s kubectl apply -f kubernetes/dashboard/ingressroute-tls-dev.yaml
echo ""
echo "installeren nginx:"
echo ""
microk8s kubectl apply -f nginx/nginx-dev.yaml
echo ""
echo "installeren portainer:"
echo ""
microk8s kubectl apply -f portainer/yaml/portainer.yaml
echo ""
echo "installeren kubeapps:"
echo ""
#microk8s kubectl apply -f 
microk8s kubectl create ns kubeapps
microk8s helm install kubeapps bitnami/kubeapps -n kubeapps
microk8s kubectl apply -f kubeapps/ingressroute-tls.yaml
microk8s enable observability
microk8s kubectl apply -f prometheus/microk8s/dev/ingressroute-tls.yaml
microk8s kubectl apply -f grafana/microk8s/dev/ingressroute-tls.yaml
echo ""
echo "installeren postgres14:"
echo ""
microk8s kubectl create ns postgres
#microk8s kubectl apply -f postgres/postgres13/postgres13dev.yaml
microk8s kubectl apply -f postgres/postgres14/postgres14dev.yaml
echo ""
echo "installeren pgadmin:"
echo ""
microk8s kubectl apply -f pgadmin/dev/pgadmin.yaml
echo ""
echo "installeren gitea:"
echo ""
microk8s kubectl create ns gitea
microk8s kubectl apply -f gitea/helm/gitea-pvc.yaml
microk8s helm install gitea bitnami/gitea -n gitea
microk8s kubectl apply -f gitea/helm/ingressrouteTCP-tls.yaml
microk8s kubectl apply -f gitea/helm/ingressroute-http.yaml
echo ""
echo "installeren harbor:"
echo ""
microk8s kubectl create ns harbor
microk8s kubectl apply -f harbor/helm/harbor-pv.yaml
microk8s kubectl apply -f harbor/helm/harbor-pvc.yaml
microk8s helm install harbor bitnami/harbor -n harbor -f harbor/helm/values.yaml
microk8s kubectl apply -f harbor/helm/ingressroute.yaml
harbor/helm/create-regstry-credentials.sh
echo ""
echo "installeren nexus:"
echo ""
microk8s kubectl apply -f nexus/nexus.yaml
microk8s kubectl apply -f nexus/ingressroute-nexus-http.yaml
microk8s kubectl apply -f nexus/ingressroute-registry-tls.yaml
microk8s kubectl apply -f nexus/ingressrouteTCP-nexus-tls.yaml
echo ""
echo "installeren sonarqube:"
echo ""
microk8s kubectl create ns sonarqube
microk8s kubectl create configmap sonar-properties --from-file="sonarqube/configmap/sonar-project.properties" -n sonarqube
microk8s kubectl apply -f sonarqube/sonarqube.yaml
echo ""
echo "installeren dependency-track:"
echo ""
microk8s kubectl apply -f deptrack/yaml/deptrack.yaml
echo ""
echo "installeren argocd:"
echo ""
microk8s kubectl create ns argocd
microk8s helm install argocd bitnami/argo-cd -n argocd -f argocd/helm/values.yaml
microk8s kubectl apply -f argocd/helm/ingressroute-tls.yaml

echo ""
echo "installeren tekton:"
echo ""
microk8s kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
microk8s kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release-full.yaml
microk8s kubectl apply -f tekton/ingressroute-tls.yaml
echo ""
echo "installeren tekton-tasks:"
echo ""
microk8s kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/git-clone/0.9/raw
microk8s kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/kaniko/0.6/raw
microk8s kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/buildah/0.5/raw
microk8s kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/maven/0.3/raw
microk8s kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/sonarqube-scanner/0.4/raw
microk8s kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/syft/0.1/syft.yaml
microk8s kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/grype/0.1/grype.yaml
microk8s kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/push-sbom-task.yaml
microk8s kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/register-change-task.yaml
microk8s kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/curl-task.yaml
microk8s kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/argocd/argocd-task-sync-and-wait.yaml
microk8s kubectl create -f /home/ubuntu/containers/kubernetes/tekton/tasks/argocd/argocd-env-configmap.yaml
/home/ubuntu/containers/kubernetes/tekton/tasks/argocd/create-argocd-env-secret.sh
echo ""
echo "installeren tekton triggers:"
echo ""
microk8s kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
microk8s kubectl  apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
echo ""
echo "installeren gitea event-listener:"
echo ""
microk8s kubectl apply -f gitea/tekton-triggers/gitea-trigger.yaml
