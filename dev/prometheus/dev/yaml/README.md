INSTALLATIE:

- kubectl create namespace monitoring

Prometheus uses Kubernetes APIs to read all the available metrics from Nodes, Pods, Deployments,
etc. 
For this reason, we need to create an RBAC policy with read access to required API groups and 
bind the policy to the monitoring namespace.
In the role  you can see that we have added get, list, and watch permissions to 
nodes, services endpoints, pods, and ingresses. 
The role binding is bound to the monitoring namespace. If you have any use case to retrieve 
metrics from any other object, you need to add that in this cluster role.

- kubectl create -f clusterRole.yaml

By externalizing Prometheus configs to a Kubernetes config map, you don’t have to build the 
Prometheus image whenever you need to add or remove a configuration. 
You need to update the config map and restart the Prometheus pods to apply the new configuration.

Configuration files zijn: prometheus.yaml en prometheus.rules, samen verpakt in config-map.yaml.

- kubectl create -f config-map.yaml

Above statement creates two files inside the container later:

kubectl exec -it prometheus-deployment-74dc6c7466-mv8bh /bin/sh -n monitoring
/prometheus $ ls /etc/prometheus/
prometheus.rules  prometheus.yml

- kubectl create -f prometheus-deployment.yaml 
- kubectl create -f prometheus-service.yaml 

VOORBEELD:

op home-page invullen:

container_cpu_usage_seconds_total

KUBE STATE METRICS Setup

Kube state metrics is available as a public docker image. You will have to deploy the following Kubernetes objects for Kube state metrics to work.

-A Service Account
-Cluster Role – For kube state metrics to access all the Kubernetes API objects.
-Cluster Role Binding – Binds the service account with the cluster role.
-Kube State Metrics Deployment
-Service – To expose the metrics

All the above Kube state metrics objects will be deployed in the kube-system namespace

- kubectl apply -f kube-state-metrics-configs/
- kubectl get deployments kube-state-metrics -n kube-system

## ☸️ kubernetes prometheus Setup

Complete prometheus monitoring stack setup on Kubernetes.

Idea of this repo to understand all the components involved in prometheus setup.

You can find the full tutorial from here--> [Kubernetes Monitoting setup Using Prometheus](https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/)

## 🚀 PCA, CKA, CKAD, CKS or KCNA Voucher Codes/Updates

If you are preparing for PCA, CKA, CKAD, CKS, or KCNA exam, **save 35%** today using code **DEVOPS35** at https://kube.promo/latest. It is a limited-time offer. Or Check out [Linux Foundation coupon]

## ✍️ Other Manifest repos

Kube State metrics manifests: https://github.com/devopscube/kube-state-metrics-configs

Alert manager Manifests: https://github.com/bibinwilson/kubernetes-alert-manager

Grafana manifests: https://github.com/bibinwilson/kubernetes-grafana

Node Exporter manifests: https://github.com/bibinwilson/kubernetes-node-exporter


