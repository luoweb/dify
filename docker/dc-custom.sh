#!/bin/bash

sed -i.bak 's#langgenius/dify-api:0.6.13#quay.io/luweb/dify-api:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-web:0.6.13#quay.io/luweb/dify-web:main#g' docker-compose.yaml
sed -i.bak 's#langgenius/dify-sandbox:0.2.1#quay.io/luweb/dify-sandbox:0.2.1#g' docker-compose.yaml
