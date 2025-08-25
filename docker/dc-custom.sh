#!/bin/bash

sed -i.bak 's#langgenius/dify-api:.*#quay.io/luweb/dify-api:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-web:.*#quay.io/luweb/dify-web:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-sandbox:.*#registry.cn-hangzhou.aliyuncs.com/roweb/dify-sandbox:latest#g' docker-compose.yaml
