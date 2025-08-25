#!/bin/bash

baseDir=$(cd `dirname $0`;pwd)
cd $baseDir

EXEC_TIME=`date +%Y%m%d%H%M%S`

tar -cvzf dc-llmapp-deploy-${EXEC_TIME}.tar.gz \
docker-compose.* \
middleware.env.example \
.env.example \
nginx \
ssrf_proxy \
startupscripts \
pip \
volumes/sandbox

tar -cvzf dc-llmmid-deploy-${EXEC_TIME}.tar.gz \
nginx \
ssrf_proxy \
startupscripts \
pip \
volumes/sandbox
