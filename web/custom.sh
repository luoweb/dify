#!/bin/bash

xsed='sed -i'
system=`uname`
if [ "$system" == "Darwin" ]; then
  echo "This is macOS"
  xsed="sed -i .bak"
else
  echo "This is Linux"
  xsed='sed -i'
fi

# custom with config
$xsed "s#'CAN_REPLACE_LOGO': 'False'#'CAN_REPLACE_LOGO': 'True'#g" ../api/config.py

# custom webui
$xsed "s#Dify#LLM AI#g" ../web/i18n/zh-Hans/login.ts
$xsed "s#Dify#LLM AI#g" ../web/app/layout.tsx
$xsed "s#POWERED BY#技术支持:#g" ../web/app/components/custom/custom-web-app-brand/index.tsx
$xsed "s#logo-site.png#logo-site-jsb.png#g" ../web/app/components/base/logo/logo-site.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ../web/app/components/header/account-about/index.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ../web/app/signin/page.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/header/account-about/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/base/chat/chat-with-history/config-panel/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/share/chat/welcome/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/share/chatbot/welcome/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/signin/normalForm.tsx
$xsed "s#https://github.com/langgenius/dify/#https://github.com/blockmap/llmai/#g" ../web/app/components/header/account-about/index.tsx
find ../web/ -name "*.tsx" | xargs grep "\- Dify" | awk -F':' '{print $1}' | $xsed "s#- Dify#- LLM#g"

# custom api:
# $xsed "s#Dify OpenAPI#BlockAI OpenAPI#g" ../api/controllers/service_api/index.py
