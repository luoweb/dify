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
$xsed "s#'CAN_REPLACE_LOGO': 'False'#'CAN_REPLACE_LOGO': 'True'#g" ${EXEC_HOME}/api/config.py
$xsed "s#Dify OpenAPI#BlockAI OpenAPI#g" ${EXEC_HOME}/api/controllers/service_api/index.py

# custom webui
$xsed "s#Dify#LLM AI#g" ${EXEC_HOME}/web/i18n/zh-Hans/login.ts
$xsed "s#Dify#LLM AI#g" ${EXEC_HOME}/web/app/layout.tsx
$xsed "s#logo-site.png#logo-site-blockai.png#g" ${EXEC_HOME}/web/app/components/base/logo/logo-site.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ${EXEC_HOME}/web/app/components/header/account-about/index.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ${EXEC_HOME}/web/app/signin/page.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ${EXEC_HOME}/web/app/components/header/account-about/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ${EXEC_HOME}/web/app/components/base/chat/chat-with-history/config-panel/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ${EXEC_HOME}/web/app/components/share/chat/welcome/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ${EXEC_HOME}/web/app/components/share/chatbot/welcome/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ${EXEC_HOME}/web/app/signin/normalForm.tsx
$xsed "s#https://github.com/langgenius/dify/#https://github.com/blockmap/llmai/#g" ${EXEC_HOME}/web/app/components/header/account-about/index.tsx
