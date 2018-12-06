#!/bin/bash
echo Drop DB $TYPEORM_DATABASE
sqlcmd -U "$TYPEORM_USERNAME" -P "$TYPEORM_PASSWORD" -S "$TYPEORM_HOST" -Q "DROP DATABASE [$TYPEORM_DATABASE]"
echo Regenerate DB script $TYPEORM_DATABASE
node ./schema/create-schema-script "$TYPEORM_DATABASE" > ./schema.sql
echo Create DB $TYPEORM_DATABASE
sqlcmd -U "$TYPEORM_USERNAME" -P "$TYPEORM_PASSWORD" -S "$TYPEORM_HOST" -i ./schema.sql
echo Regenerate entity models for $TYPEORM_DATABASE
yarn typeorm-model-generator -d $TYPEORM_DATABASE -u $TYPEORM_USERNAME -x $TYPEORM_PASSWORD -e $TYPEORM_CONNECTION -h $TYPEORM_HOST --ce=pascal --cp=camel --lazy=true -o ./src
echo DONE
