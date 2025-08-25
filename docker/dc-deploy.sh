#!/bin/bash

baseDir=$(cd `dirname $0`;pwd)
cd $baseDir

EXEC_TIME=`date +%Y%m%d%H%M%S`

tar -cvzf dc-llmapp-deploy-${EXEC_TIME}.tar.gz \
dc-llmapp.* \
docker-compose.* \
.env.example \
nginx \
startupscripts \
pip \
volumes/sandbox

tar -cvzf dc-llmmid-deploy-${EXEC_TIME}.tar.gz \
dc-llmmid.* \
docker-compose.middleware.yaml \
middleware.env.example \
ssrf_proxy \
startupscripts \
pip \
volumes/sandbox
