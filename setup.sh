#!/bin/bash

echo 'Cloning bitsensor/elastalert'
if [ ! -d elastalert/elastalert ]; then
cd elastalert
git clone https://github.com/bitsensor/elastalert.git
else
echo '--> Elastalert already cloned'
fi

echo 'Bringing up the Web & ELK services (Docker)'
docker-compose up

echo 'Building ELK index for "security_log"'
curl -X PUT "localhost:9200/security_log" -H 'Content-Type: application/json' -d'
{
    "mappings" : {
        "record" : {
            "properties" : {
                "datetime" : { "type" : "date" }
            }
        }
    }
}'

echo 'Executing Docker command for Elastalert'
cd elastalert
docker rm elastalert; docker run -p 3030:3030 \
    -v `pwd`/config.yaml:/opt/elastalert/config.yaml \
    -v `pwd`/config.json:/opt/elastalert-server/config/config.json \
    -v `pwd`/rules:/opt/elastalert/rules \
    -v `pwd`/rule_templates:/opt/elastalert/rule_templates \
    --net="host" \
    --name elastalert bitsensor/elastalert:latest

echo 'Creating required Elastalert indexes'
docker exec -it elastalert elastalert-create-index

cd ../web
composer install

echo 'To trigger the test message alert, use: php trigger.php'
