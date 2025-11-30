#!/bin/bash

baseDir=$(cd `dirname $0`;pwd)
cd $baseDir
EXEC_TIME=`date +%Y%m%d%H%M%S`

# dc-llmapp
sed -i.bak 's#langgenius/dify-api:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-api:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-web:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-web:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-sandbox:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-sandbox:0.2.12#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-plugin-daemon:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-plugin-daemon:0.3.3-local#g' docker-compose.yaml

# dc-llmmid
sed -i.bak 's#langgenius/dify-sandbox:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-sandbox:0.2.12#g' dc-llmmid.yaml
sed -i.bak 's#langgenius/dify-plugin-daemon:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-plugin-daemon:0.3.3-local#g' dc-llmmid.yaml

## env
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g' middleware.env > dc-llmmid.env
## conf
sed -i.bak 's#key: dify-sandbox#key: llmdb-sandbox#g' ./volumes/sandbox/conf/config.yaml.example
sed -i.bak 's#key: dify-sandbox#key: llmdb-sandbox#g' ./volumes/sandbox/conf/config.yaml

## yaml
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g;s#-dify#-llmdb#g;s#./middleware.env#./dc-llmmid.env#g' docker-compose.middleware.yaml > dc-llmmid.yaml


# sed -i.bak -e 's#difyai123456#llmdb123456#g; \
#        s#-dify-sandbox#-llmdb-sandbox#g; \
#        s#-dify_plugin#-llmdb_plugin#g; \
#        s#-dify#-llmdb#g' \
#     docker-compose.middleware.yaml

# dc-llmapp

## env
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g' .env.example > dc-llmapp.env

## conf

### parm
sed -i.bak 's#LOG_TZ=UTC#LOG_TZ=Asia/Shanghai#g;s#EXPOSE_NGINX_PORT=80#EXPOSE_NGINX_PORT=8050#g;s#EXPOSE_NGINX_SSL_PORT=443#EXPOSE_NGINX_SSL_PORT=8543#g;s#DB_PLUGIN_DATABASE=dify_plugin#DB_PLUGIN_DATABASE=llmdb_plugin#g;s#FORCE_VERIFYING_SIGNATURE=true#FORCE_VERIFYING_SIGNATURE=false#g;s#PLUGIN_MAX_PACKAGE_SIZE=52428800#PLUGIN_MAX_PACKAGE_SIZE=524288000#g;s#DB_DATABASE=dify#DB_DATABASE=llmdb#g' ./dc-llmapp.env

### env 
ip_addr="192.168.3.136"
sed -i.bak "s#=http://ssrf_proxy:3128#=http://${ip_addr}:3128#g;s#=http://sandbox:8194#=http://${ip_addr}:8194#g;s#http://plugin_daemon:5002#http://${ip_addr}:5002#g;s#REDIS_HOST=redis#REDIS_HOST=${ip_addr}#g;s#redis:6379#${ip_addr}:6379#g;s#DB_HOST=db#DB_HOST=${ip_addr}#g" ./dc-llmapp.env

## yaml
sed -e 's#difyai123456#llmdb123456#g;s#-dify-sandbox#-llmdb-sandbox#g;s#-dify_plugin#-llmdb_plugin#g;s#POSTGRES_MAX_CONNECTIONS=100#POSTGRES_MAX_CONNECTIONS=400#g;s#-dify#-llmdb#g;s#./middleware.env#./dc-llmmid.env#g' docker-compose.yaml > dc-llmapp.yaml
sed '/^  # Qdrant vector store./,$d' dc-llmapp.yaml > dc-llmapp-v2.yaml

# NAS避免端口冲突
sed -i 's#6379#6379#g' dc-*.yaml
sed -i 's#5432#5431#g' dc-*.yaml

cat > dc-llmapp-v2.yaml << EOF
networks:
  # create a network between sandbox, api and ssrf_proxy, and can not access outside.
  ssrf_proxy_network:
    driver: bridge
    internal: true
EOF
# sed '/^  qdrant:/,$d' dc-llmapp.yaml > dc-llmapp-v2.yaml
# sed -i.bak '/^  myscale:/,/^  [a-z]/{//!d;/^  [a-z]/!d}' dc-llmapp.yaml
# sed -i.bak '/^  myscale:/,/^  [a-z]/d' dc-llmapp.yaml
# # ...existing code...
# sed -i.bak '/^  myscale:/,/^  [a-z]/d' dc-llmapp.yaml