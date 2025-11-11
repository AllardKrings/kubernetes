kubectl apply -f pvc.yaml

helm repo add docker-mailserver https://docker-mailserver.github.io/docker-mailserver-helm

helm upgrade --install docker-mailserver docker-mailserver/docker-mailserver --namespace mail --create-namespace

kubectl exec -it -n mail deploy/docker-mailserver -- bash

  setup email add admin@allarddcs.nl Dockermail01@

  setup config dkim keysize 2048 domain 'allarddcs.nl'

2025-01-22 13:09:42+00:00 INFO  rspamd-dkim: Here is the content of the TXT DNS record mail._domainkey.allarddcs.nl that you need to create:

v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwiLS07tI7kyAeIiR+hroK2r2v6/5/2CjLY2kzM2RA4nfnb/ZFG5/tYEF34NMBsZ4/fqki+ACUyN+65d1b7qa2Lxl+sj6honkVnmZHmayYhZbRp1odgim4IOdxRhqnJ3S0T3aVN7XLIgDng2/Uoyl/78qlPWMRZFbxe4h2z8iw3KTtTh3IrMsDnWWeatYO+Bx2WJDMc63qKuiZZ2XL4cC6ptrhKHRcAgErZFlUFyrZzfj7LhXx0Mq+6XLJGAGuVgo797qe4WM/y80PjoGQKCM9VduyFJd4du5DbGA9mhsB3Pu8o+MUt17xb/iWkpLMGO/0GBgLwLM5j7lfDwYOcFmDwIDAQAB

rspamd: stopped
rspamd: started



helm upgrade docker-mailserver docker-mailserver/docker-mailserver -n mail



supervisorctl restart postfix
in etc/postfix/generic

@allarddcs.nl     @allarddcs.nl
