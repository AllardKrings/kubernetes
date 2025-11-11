sudo /usr/local/bin/k3s-uninstall.sh
sudo cp k3s /usr/local/bin/
INSTALL_K3S_SKIP_DOWNLOAD="true" bash -x k3s-install.sh
export KUBECONFIG=~/.kube/config
mkdir ~/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
chmod 600 "$KUBECONFIG"
kubectl get pod -A
