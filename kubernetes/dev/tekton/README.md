#Installeren tekton-pipelines:

kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

#Installeren tekton-dashboard:

kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/dashboard/latest/release-full.yaml

#daarna:

kubectl apply -f ingressroute-tls.yaml

Taken die je vaak nodig hebt:

kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/git-clone/0.9/raw
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/kaniko/0.6/raw
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/buildah/0.5/raw
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/maven/0.3/raw
kubectl apply -f https://api.hub.tekton.dev/v1/resource/tekton/task/sonarqube-scanner/0.4/raw
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/syft/0.1/syft.yaml
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/grype/0.1/grype.yaml
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/argocd-task-sync-and-wait/0.2/argocd-task-sync-and-wait.yaml
kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/push-sbom-task.yaml
kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/register-change-task.yaml
kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/curl-task.yaml
kubectl apply -f /home/ubuntu/containers/kubernetes/tekton/tasks/argocd/argocd-task-synt-and-wait.yaml

## Voor deze laatste task moet je ook een configmap en een secret aanmaken!!


#om TKN command-line te gebruiken:

microk8s config > admin.conf
sudo mv admin.conf /etc/kubernetes/

#Tekton triggers:

kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
