#installatie

na installatie:

#catalog toeviegen va GUI:

url:

https://gitea-dev.allarddcs.nl/allard/kubernetes/raw/branch/master/catalog-info.yaml

#als database connectie nietw erkt controleren welke connectie-parameters geladen zijn door in de container:

node -e "console.log(require('knex')({
  client: 'pg',
  connection: process.env.DATABASE_URL
}).raw('select 1+1'))"

uit te voeren. Als je dan "connection undefined" ziet weet je hoe laat het is.
