3) microk8s enable dashboard
2) creer account: kubectl apply -f ServiceAccount.yaml
3) creeer clusterrolebinding: kubectl aply -f ClusterRoleBinding.yaml
4) creeer ingressroute: kubectl apply -f Ingressroute-tls.yaml
5) genereer token: 
kubectl -n kube-system create token admin-user --duration=8544h

Herinstallatie:

na herinstallatie moet je de config opnieuw kopieren anders klopt het certificaat niet meer:

sudo cp -i /var/snap/microk8s/current/credentials/client.config  ${HOME}/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/configsudo chown $(id -u):$(id -g) $HOME/.kube/configsudo chown $(id -u):$(id -g) $HOME/.kube/configsudo chown $(id -u):$(id -g) $HOME/.kube/config



