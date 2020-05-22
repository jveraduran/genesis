#!/bin/sh

set -e


if [ -z $PLUGIN_ROLE ]; then
    echo "ROLE Name attribute not set"
    exit 1
fi

if [ -z $PLUGIN_CONSUL_PATH_TO_DATABASE ]; then
  echo "DATABASE Name attribute not set"
  exit 2
elif [ ! -z $PLUGIN_CONSUL_PATH_TO_DATABASE ]; then
  echo "Getting DATABASE Name from Consul key -> $PLUGIN_CONSUL_PATH_TO_DATABASE"
  export DATABASE=`consul kv get $PLUGIN_CONSUL_PATH_TO_DATABASE`
  echo "The Name to use: $DATABASE"
fi

echo "Exporting Local Variables"
TEMP=$(vault read -format=json database/creds/$PLUGIN_ROLE | jq -r .data.username,.data.password)
PLUGIN_DATABASE_USER=$(echo -e "${TEMP}" | { read line1 ; read line2 ; echo "$line1" ; })
PLUGIN_DATABASE_PASSWORD=$(echo -e "${TEMP}" | { read line1 ; read line2 ; echo "$line2" ; })

# Connection Test
# echo "Conectando a Base de Datos"
# psql "host=$PLUGIN_DATABASE.postgres.database.azure.com port=5432 dbname=$PLUGIN_DATABASE user=$PLUGIN_DATABASE_USER@$PLUGIN_DATABASE password=$PLUGIN_DATABASE_PASSWORD sslmode=require"

echo "Setting Up Flyway Properties"

echo "flyway.user=$PLUGIN_DATABASE_USER@$DATABASE" > flyway.properties
echo "flyway.password=$PLUGIN_DATABASE_PASSWORD" >> flyway.properties
echo "flyway.url=jdbc:postgresql://$DATABASE.postgres.database.azure.com:5432/$DATABASE?user=$PLUGIN_DATABASE_USER@$DATABASE&password=$PLUGIN_DATABASE_PASSWORD&sslmode=require" >> flyway.properties
echo "flyway.locations=filesystem:migrations" >> flyway.properties
echo "flyway.sqlMigrationPrefix=" >> flyway.properties
echo "flyway.sqlMigrationSeparator=_" >> flyway.properties

echo "Cleaning Old Flyway Executions"
mvn -ntp -Dflyway.configFile=flyway.properties flyway:clean

echo "Deploying Database Changes"
mvn -ntp -Dflyway.configFile=flyway.properties flyway:migrate