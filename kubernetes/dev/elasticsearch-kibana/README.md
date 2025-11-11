CRD's INSTALLEREN:

Handleiding komt van: 

www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html

Installeren CRD's

kubectl create -f https://download.elastic.co/downloads/eck/2.5.0/crds.yaml

customresourcedefinition.apiextensions.k8s.io/agents.agent.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/apmservers.apm.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/beats.beat.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/elasticmapsservers.maps.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/elasticsearchautoscalers.autoscaling.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/elasticsearches.elasticsearch.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/enterprisesearches.enterprisesearch.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/kibanas.kibana.k8s.elastic.co created


Ik heb een loadbancer toegevoerd )kibana-lb.yaml , die werkt vanaf buiten niet (relative url?) maar wel op de nodeport.

USER/PASSWORD:

user: elastic
password: 
kubectl get secret quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
