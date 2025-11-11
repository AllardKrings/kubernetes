sudo microk8s kubectl exec itop-66c56dd4bd-bb2t6 -- chown www-data:www-data /var/www/html/conf
 exec my-itop /install-toolkit.sh
 exec my-itop conf-w
 exec my-itop conf-ro
