microk8s kubectl delete configmap sonar-properties 
microk8s kubectl create configmap sonar-properties --from-file="/home/ubuntu/containers/kubernetes/sonarqube/configmap/sonar-project.properties" 
