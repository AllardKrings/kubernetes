#build container 

setup.sh is een script waarmee vanuit de backstage git repo een docker image wordt gebouwd met daarin:

github, gitea, techdocs

#installatie

kubectl apply -f backstage.yaml

maakt connectie met postgres13 database


#na installatie:

als database connectie niet werkt controleren welke connectie-parameters geladen zijn door in de container:

node -e "console.log(require('knex')({
  client: 'pg',
  connection: process.env.DATABASE_URL
}).raw('select 1+1'))"

uit te voeren. Als je dan "connection undefined" ziet weet je hoe laat het is.

