#VOORAF:
========
De processor moet avx instructieset aankunnen.
Dit kun je controleren door het volgende commando uit te voeren in je virtualbx vm:

	cat /proc/cpuinfo | grep flags

output:

	flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
        pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good 
        nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid 
        sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm
        3dnowprefetch pti fsgsbase bmi1 avx2 bmi2 invpcid rdseed adx clflushopt arat

Je moet dan avx en sse4_2  tussen de flags zien staan:

anders moet je op de windows host het commando

	bcdedit /set hypervisorlaunchtype off

uitvoeren.

#INSTALLATIE
============
helm install mongodb bitnami/mongodb-sharded -n mongodb -f values.yaml

OUTPUT:

NAME: mongodb
LAST DEPLOYED: Mon Jul  7 09:10:41 2025
NAMESPACE: mongodb
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: mongodb-sharded
CHART VERSION: 9.1.1
APP VERSION: 8.0.4

The MongoDB&reg; Sharded cluster can be accessed via the Mongos instances in port 27017 on the following DNS name from within your cluster:

    mongodb-mongodb-sharded.mongodb.svc.cluster.local

To get the root password run:

    export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace mongodb mongodb-mongodb-sharded -o jsonpath="{.data.mongodb-root-password}" | base64 -d)

To connect to your database run the following command:

    kubectl run --namespace mongodb mongodb-mongodb-sharded-client --rm --tty -i --restart='Never' --image docker.io/bitnami/mongodb-sharded:8.0.4-debian-12-r1 --command -- mongosh admin --host mongodb-mongodb-sharded --authenticationDatabase admin -u root -p $MONGODB_ROOT_PASSWORD

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace mongodb svc/mongodb-mongodb-sharded 27017:27017 &
    mongosh --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD

WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
  - configsvr.resources
  - mongos.resources
  - shardsvr.dataNode.resources
+info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
