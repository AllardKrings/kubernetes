#installatie microok8s:
sudo snap install microk8s --classic --channel=1.29
#enablen juiste features
microk8s enable community
microk8s enable dashboard
microk8s enable metallb 192.168.2.230-192.168.2.239
microk8s enable rbac
microk8s enable cert-manager
microk8s kubectl apply -f kubernetes/cert-manager/cluster-issuer.yaml
microk8s enable ingress
#installeren kubernetes-dashboard:
microk8s kubectl apply kubernetes/dashboard/serviceaccount.yaml
microk8s kubectl apply kubernetes/dashboard/clusterrolebinding.yaml
microk8s kubectl apply -f kubernetes/dashboard/ingressroute-tls-odroid.yaml
#installeren traefik:
microk8s kubectl create ns traefik
helm install traefik traefik/traefik -f traefik/helm/values.yaml -n traefik
microk8s kubectl apply -f traefik/helm/tlsoption.yaml
microk8s kubectl apply -f traefik/helm/odroid/ingressroute-dashboard.yaml
#installatie postgres-operator
microk8s kubectl apply -f \
https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/\
releases/cnpg-1.22.0.yaml
#installatie nfs-provisioner
microk8s disable hostpath-storage
microk8s helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
microk8s helm3 repo update
microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs \
    --namespace kube-system \
    --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet
microk8s kubectl apply -f nfs/nfs-storage-class.yaml
microk8s kubectl patch storageclass nfs-csi \
    -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
#installatie minio
microk8s kubectl create ns postgres
kubectl apply -f minio/minio.yaml
#installatie postgres13 cluster met harbor als eerste database:
microk8s kubectl apply -f cnpg/recovery.yaml
microk8s kubectl apply -f cnpg/postgres13-lb.yaml
