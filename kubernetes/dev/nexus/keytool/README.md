keytool -genkeypair -keystore keystore.jks -storepass password -alias alldcs.nl \
-keyalg RSA -keysize 2048 -validity 5000 -keypass password \
-dname 'CN=*.alldcs.nl, OU=Sonatype, O=Sonatype, L=Unspecified, ST=Unspecified, C=US' \
-ext 'SAN=DNS:nexus-dev.alldcs.nl,DNS:registry-dev.alldcs.nl'

keytool -exportcert -keystore keystore.jks -alias alldcs.nl -rfc > alldcs.nl.cert

keytool -importkeystore -srckeystore keystore.jks -destkeystore alldcs.nl.p12 -deststoretype PKCS12

openssl pkcs12 -nocerts -nodes -in alldcs.nl.p12 -out alldcs.nl.key
