#als je niet kunt inloggen omdat redis gecrashed is:
op de LP ga naar redis directory en dan:

sudo redis-check-aof --fix appendonly.aof.1.incr.aof

#Opmerkingen:

De goharbor-versie is alleen beschikbaar voor AMD-processorarchitectuur.
Je moet dus de bitnami-versie gebruiken.

#installatie:

kubectl create ns harbor
helm install harbor bitnami/harbor -n harbor -f values.yaml

De bitnami helm chart maakt zelf een certificaat aan via cert-manager en letsencrypt. 
De bitnami helm chart maakt zelf een ingress aan en een certificaat aan. 
Je hoeft dus geen certificaat of ingressroutes te definieren.

#trivy

In eerste instantie is de status "unhealthy" 

#Tekton

In de tekton-pipeline wordt het secret "registry-credentials" gemount om de repositories te kunnen 
gebruiken. 

#Met Docker naar HARBOR VIA HTTP
================================
nano /etc/docker/daemon.json:

{
    "insecure-registries" : ["localhost:32000","harbor.allarddcs.nl"]
}

systemctl restart docker










===========================================================
1. Enable Microk8s to access Harbor-instance:

Create certs directory:

sudo mkdir -p /var/snap/microk8s/current/args/certs.d/harbor.alldcs.nl

copy the certificate from Harbor:

sudo cp ca.crt /var/snap/microk8s/current/args/certs.d/harbor.alldcs.nl

2. Edit /var/snap/microk8s/current/args/containerd-template.toml

  [plugins."io.containerd.grpc.v1.cri".registry.configs."harbor.alldcs.nl".tls]
     insecure_skip_verify = true


Password opvragen:
==================

echo "Password: $(kubectl -n default get secret harbor-core-envvars -n harbor 
-o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 -d)"




