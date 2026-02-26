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
find ../api -type f -name "*.py" | xargs -I@ sh -c "sed -i.bak 's#DifyApp#LLMAIApp#g' @"
find ../api -type f -name "*.py" -o -name "*.yaml"| grep -vE "remove_extra_tracing_app_config_table|model.py|wraps.py|setup.py|init_validate.py|account_service.py"| xargs grep -E "[ '\"]Dify[ '\"]"| grep -vE "DifySetup|account_service|DifySpanAttributes"
find ../api -type f -name "*.py" -o -name "*.yaml"| grep -vE "remove_extra_tracing_app_config_table|model.py|wraps.py|setup.py|init_validate.py|account_service.py"| xargs grep -E "[ '\"]Dify[ '\"]"| grep -vE "DifySetup|account_service|DifySpanAttributes"| awk -F ':' '{print $1}' | xargs -I@ sh -c "sed -i.bak 's#Dify#LLMAI#g' @"
exit 0
