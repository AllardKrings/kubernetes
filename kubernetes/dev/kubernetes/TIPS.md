#Als een pvc in de status "terminating" blijft hangen kan het volgende commando 
#helpen:

kubectl patch pvc {PVC_NAME} -p '{"metadata":{"finalizers":null}}'

#Switchen van context:

kubectl config set-context --current --namespace=tektontutorial

#Als je bij uitvoeren van kubectl  "connection refused " krijgt
#kunnen de volgende commando's helpen:

sudo microk8s.refresh-certs --cert ca.crt
sudo microk8s.refresh-certs --cert server.crt

aanpassen clusternaam:

nano /var/snap/micrk8s/current/credentials/client.config

Daarna certificaten opnieuw genereren:

sudo microk8s.refresh-certs --cert ca.crt
sudo microk8s.refresh-certs --cert server.crt

kubectl configuratie opnieuw genereren:

microk8s.kubectl config view --raw > $HOME/.kube/config

#metallb speaker permission errors 

sudo nano /etc/apparmor.d/cri-containerd.apparmor.d
network, 
sudo apparmor_parser -r /etc/apparmor.d/cri-containerd.apparmor.d

#volle schijf:

sudo microk8s ctr images list -q | xargs -r sudo microk8s ctr images rm

