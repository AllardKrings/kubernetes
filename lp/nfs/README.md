NFS Installatie:
================

helm repo add nfs-subdir-external-provisioner \
https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner

helm install -n nfs-provisioning --create-namespace nfs-subdir-external-provisioner \
nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=192.168.2.110 --set nfs.path=/opt/dynamic-storage


Testen:

kubectl apply -f demo-pvc.yaml
kubectl apply -f test-pod.yaml


kubectl exec -it test-pod -n nfs-provisioning -- df -h

#nfs als default storage instellen:

kubectl get storageclass

NAME                   PROVISIONER                                     RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
microk8s-hostpath      microk8s.io/hostpath                            Delete          WaitForFirstConsumer   false                  33m
nfs-client             cluster.local/nfs-subdir-external-provisioner   Delete          Immediate              true                   18m


kubectl patch storageclass microk8s-hostpath -p \
'{"metadata": \
{"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass nfs-client -p \
'{"metadata": \
{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
