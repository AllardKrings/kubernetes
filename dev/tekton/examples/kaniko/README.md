KANIKO voorbeeld:

vergeet niet de juiste docker credentials in een secret te zetten:

sysctl -w fs.inotify.max_user_instances=100000

cat ~/.docker/config.json | base64 -w0

Output editen in docker-credentials.yaml

kubectl create -f docker-credentials.yaml	

Dit voorbeeld werk niet op ARM!!!


harbor.alldcs.nl toevoegen aan registries voor microk8s:
========================================================

MicroK8s 1.23 and newer versions use separate hosts.toml files for each image registry. For registry http://10.141.241.175:32000, this would be at /var/snap/microk8s/current/args/certs.d/10.141.241.175:32000/hosts.toml. First, create the directory if it does not exist:

sudo mkdir -p /var/snap/microk8s/current/args/certs.d/harbor.alldcs.nl
sudo touch /var/snap/microk8s/current/args/certs.d/harbor.alldcs/hosts.toml
Then, edit the file we just created and make sure the contents are as follows:

# /var/snap/microk8s/current/args/certs.d/harbor.alldcs.nl/hosts.toml
server = "http://harbor.alldcs.nl"

[host."http://10.141.241.175:32000"]
capabilities = ["pull", "resolve"]

#/var/snap/microk8s/current/args/containerd-template.toml

[plugins."io.containerd.grpc.v1.cri".registry.configs."172.16.4.93:5000".tls]
      insecure_skip_verify = true

Restart MicroK8s to have the new configuration loaded:

microk8s stop
microk8s start

===========

Het voorbeeld werkt niet naar behoren omdat de site niet is gebouwd.
Tevens in /etc/hosts toegevoegd : 80.60.8.14 harbor.alldcs.nl anders werkt 
DNS-resolver niet goed.
