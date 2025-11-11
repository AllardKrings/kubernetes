keytool -genkeypair -keystore keystore.jks -storepass password -alias allarddcs.nl \
-keyalg RSA -keysize 2048 -validity 5000 -keypass password \
-dname 'CN=*.allarddcs.nl, OU=Sonatype, O=Sonatype, L=Unspecified, ST=Unspecified, C=US' \
-ext 'SAN=DNS:nexus-riscv.allarddcs.nl,DNS:registry-riscv.allarddcs.nl'

keytool -exportcert -keystore keystore.jks -alias allarddcs.nl -rfc > allarddcs.nl.cert

keytool -importkeystore -srckeystore keystore.jks -destkeystore allarddcs.nl.p12 -deststoretype PKCS12

openssl pkcs12 -nocerts -nodes -in allarddcs.nl.p12 -out allarddcs.nl.key
