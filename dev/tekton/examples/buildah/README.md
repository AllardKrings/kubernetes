Dit is een pipeline voor buildah.

let op:

gebruik de buildah task van Tekton zelf:

kubectl apply -f 
https://api.hub.tekton.dev/v1/resource/tekton/task/buildah/0.5/raw

Deze task heeft een workspace "dockerconfig" die via de pipeline is gekoppeld aan 
workspace "dockerconfig-ws" die op zijn beurt in de pipelinerun gekoppeld is aan  
een secret "dockerconfig-secret dat gedefinieerd wordt conform 
dockerconfig-secret.yaml


