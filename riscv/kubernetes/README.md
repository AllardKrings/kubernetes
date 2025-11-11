#installeren:

INSTALL_K3S_SKIP_DOWNLOAD="true" bash -x k3s-install.sh


#kubeconfig aanmaken:

export KUBECONFIG=~/.kube/config
mkdir ~/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
chmod 600 "$KUBECONFIG"

#Node toevoegen:

-	eerst token van de server ophalen en bewaren:

export mynodetoken=$(sudo cat /var/lib/rancher/k3s/server/node-token)

-	dan op de andere computer k3s installeren als agent:

INSTALL_K3S_SKIP_DOWNLOAD="true" K3S_URL=https://myserver:6443 K3S_TOKEN=$mynodetoken bash -x k3s-install.sh



