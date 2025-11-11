=#Postgress13:

installeren van extensies:
- inloggen incontainer:
 kubectl exec -it postgres13-0 -n postgres
- inloggen op dadabase clair:
 psql -U clair --dbname=clair 
- sql uitvoeren:
 create extension if not exists "uuid-ossp";

/q

exit
