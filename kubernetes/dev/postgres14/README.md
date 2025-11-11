user: harbor
password: harbor

#corrupte WAL-archive

#postgres starten zonder database te starten door volgende toe te voegen in yaml:: 

        command: ["sh"]
        args: ["-c", "while true; do echo $(date -u) >> /tmp/run.log; sleep 5; done"]

#dan inloggen in draaiende container

kubectl exec -it postgres14-0 -n postgres -- sh

#Switchen naar user POSTGRES

su postgres

#WAL-arhive resetten:

pg_resetwal /var/lib/postgresql/data -f
