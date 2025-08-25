#!/bin/bash

baseDir=$(cd `dirname $0`;pwd)
cd $baseDir
EXEC_TIME=`date +%Y%m%d%H%M%S`

# dc-llmapp
sed -i.bak 's#langgenius/dify-api:.*#quay.io/luweb/dify-api:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-web:.*#quay.io/luweb/dify-web:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-sandbox:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-sandbox:latest#g' docker-compose.yaml

# dc-llmmid

## env
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g' middleware.env > dc-llmmid.env

## yaml
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g;s#-dify#-llmdb#g;s#./middleware.env#./dc-llmmid.env#g' docker-compose.middleware.yaml > dc-llmmid.yaml

# sed -i.bak -e 's#difyai123456#llmdb123456#g; \
#        s#-dify-sandbox#-llmdb-sandbox#g; \
#        s#-dify_plugin#-llmdb_plugin#g; \
#        s#-dify#-llmdb#g' \
#     docker-compose.middleware.yaml

# dc-llmapp

## env
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g' env.example > dc-llmapp.env

## yaml
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g;s#-dify#-llmdb#g;s#./middleware.env#./dc-llmmid.env#g' docker-compose.yaml > dc-llmapp.yaml
