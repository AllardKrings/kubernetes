#eventlistener voor gitea installeren:

	serviceaccount tekton-robot aanmaken:

kubectl apply -f rbac.yaml

kubectl apply -f gitea-binding.yaml

kubectl apply -f gitea-listener.yaml

kubectl apply -f gitea-pipeline-template.yaml

	webhook aanmaken in gitea:

http://el-gitea-listener.default:8080
