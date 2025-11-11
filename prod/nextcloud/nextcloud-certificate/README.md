AANMAKEN CERTIFICAAT:

Uitleg:

omdat traefik de TLS interrupt doet moet Nextcloud Traefik vertrouwen. 
Er komt immers alleen http verkeer bij Nextcloud binnen.
Verkeer van buiten moet echter wel weten dat het echt met  Nextcloud praat. 
Daarom werkt het Trafik default certificate ook niet. 
Je moet dus een eigen certificaat aanmaken voor nextcloud-prod.allard.dcs. 
Dit doe je in mijn geval via cert-manager die op zijn beurt de cert-issuer Letstencrypt gebruikt. In je route geef je dan ipv TLS Letsencrypt de naam van het secret op dat je certificaat bevat. Dus Traefik doet nog steeds de TLS-interrupt, 
maar gebruikt daarbij het Nextcloud certificaat i.p.v. het default certificaat.


2.Maak certificaat aan:

kubectl apply -f certificate.yaml

3.Updaten route:

apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: nextcloud
  namespace: traefik
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`nextcloud-prod.allarddcs.nl`)
      kind: Rule
      services:
        - name: nextcloud
          port: 80
  tls:
    secretName: nextcloud-prod.allarddcs.nl

4.herstarten traefik:

kubectl rollout restart deployment traefik -n traefik

5: checken certificaat issuer:

openssl s_client -connect nextcloud-prod.allarddcs.nl:443 -servername nextcloud-prod.allarddcs.nl | openssl x509 -noout -text | grep "Issuer:"

Dit mag nu niet meer TRAEFIK DEFAULT CERTIFICATE zijn.
