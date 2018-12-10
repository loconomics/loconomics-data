#!/bin/bash

set -e

TYPEORM_DATABASE=${TYPEORM_DATABASE:=loconomics}
TYPEORM_USERNAME=${TYPEORM_USERNAME:=sa}
TYPEORM_PASSWORD=${TYPEORM_PASSWORD:=Password!!11}
TYPEORM_HOST=${TYPEORM_HOST:=localhost}
TYPEORM_ENGINE=${TYPEORM_CONNECTION:=mssql}

echo Drop DB $TYPEORM_DATABASE
sqlcmd -U "$TYPEORM_USERNAME" -P "$TYPEORM_PASSWORD" -S "$TYPEORM_HOST" -Q "DROP DATABASE [$TYPEORM_DATABASE]"
echo Regenerate DB script $TYPEORM_DATABASE
node ./schema/create-schema-script "$TYPEORM_DATABASE" > ./schema.sql
echo Create DB $TYPEORM_DATABASE
sqlcmd -U "$TYPEORM_USERNAME" -P "$TYPEORM_PASSWORD" -S "$TYPEORM_HOST" -i ./schema.sql
echo Regenerate entity models for $TYPEORM_DATABASE
yarn typeorm-model-generator -d $TYPEORM_DATABASE -u $TYPEORM_USERNAME -x $TYPEORM_PASSWORD -e $TYPEORM_ENGINE -h $TYPEORM_HOST --ce=pascal --cp=camel --lazy=true --noConfig -o ./src/entities
echo Patching entities
cp src/entities.patch/* src/entities
echo DONE
