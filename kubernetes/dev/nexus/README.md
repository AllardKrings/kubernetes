user: admin
password: Nexus01@

#installatie

postgres14 starten als dat nog niet is gebeurd
certificaat is geinstalleerd met keytool en staat op nfs-share

ingressrouteTCP-routes aanmaken voor registry

ingressroutes HTTP en TLS aanmaken voor nexus  (nodig voor compileren met maven)

kubectl apply -f nexus.yaml
i.v.m. permissions (zie logfile) indien nodig op sudo chmod +R /mnt/nfs_share/nexus uitvoeren 
admin password staat in data-dir op de nfs-share 

#SSL:



#Repository-routes configureren:

In nexus kun je een repository definieren van het type "Docker".

Die geef je dan een eigen poortnummer, anders dan de poort die je al gebruikt voor de GUI.
Deze poort moet je ook als ingressrouteTCP ontsluiten maar dan wel op een andere domeinnaam 
bv: "registry-riscv.allarddcs.nl".
Deze tweede route heeft hetzelfde "entrypoint"  als de GUI, namelijk "websecure" 
