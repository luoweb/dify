#!/bin/bash

xsed='sed -i'
system=`uname`
if [ "$system" == "Darwin" ]; then
  echo "This is macOS"
  xsed="sed -i ''"
else
  echo "This is Linux"
  xsed='sed -i'
fi
EXEC_HOME=`pwd`
# custom with config

# custom api:
# $xsed "s#'CAN_REPLACE_LOGO': 'False'#'CAN_REPLACE_LOGO': 'True'#g" ${EXEC_HOME}/api/config.py
# $xsed "s#Dify OpenAPI#BlockAI OpenAPI#g" ${EXEC_HOME}/api/controllers/service_api/index.py

find ../api -type f -name "*.py" -o -name "*.yaml"| grep -v remove_extra_tracing_app_config_table| xargs grep -E "[ '\"]Dify[ '\"]"
find ../api -type f -name "*.py" -o -name "*.yaml"| grep -v remove_extra_tracing_app_config_table| xargs grep -E "[ '\"]Dify[ '\"]"| awk -F ':' '{print $1}' | xargs -I@ sh -c "sed -i.bak 's#Dify#LLMAI#g' @"

exit 0
