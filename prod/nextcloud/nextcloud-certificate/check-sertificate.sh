openssl s_client -connect nextcloud-prod.allarddcs.nl:443 -servername nextcloud-prod.allarddcs.nl | openssl x509 -noout -text | grep "Issuer:"
