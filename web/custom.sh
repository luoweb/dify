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
# $xsed "s#'CAN_REPLACE_LOGO': 'False'#'CAN_REPLACE_LOGO': 'True'#g" ../api/config.py

# custom webui
# find ../web/ -type f -name "*.ts" -o -name "*.tsx" | xargs grep -E "[ '\"]Dify[ '\"]"| awk -F ':' '{print $1}' | xargs -I@ bash -c "${xsed} -i.bak 's#Dify#LLMAI#g' @"
$xsed "s#Dify#LLM AI#g" ../web/i18n/zh-Hans/login.ts
$xsed "s#Dify#LLM AI#g" ../web/app/layout.tsx
$xsed "s#Dify#LLM AI#g" "../web/app/(commonLayout)/layout.tsx"
$xsed "s#Dify#LLM AI#g" "../web/app/(commonLayout)/datasets/page.tsx"
$xsed "s#'Dify'#'LLMAI'#g"  ../web/app/components/base/icons/src/public/common/Dify.tsx
$xsed "s#Powered by Dify#Powered by LLMAI#g"  ../web/app/components/base/chat/embedded-chatbot/index.tsx
$xsed "s#POWERED BY#技术支持:#g" ../web/app/components/custom/custom-web-app-brand/index.tsx

$xsed "s#logo-site.png#logo-site-jsb.png#g" ../web/app/components/base/logo/logo-site.tsx
$xsed "s#logo.svg#logo-llmapp.svg#g" ../web/app/components/base/logo/logo-site.tsx
$xsed "s#logo-monochrome-white.svg#logo-monochrome-white-llmapp.svg#g" ../web/app/components/base/logo/logo-site.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ../web/app/components/header/account-about/index.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ../web/app/signin/page.tsx
$xsed "s#https://dify.ai#https://llm.ai#g" ../web/app/components/header/account-about/index.tsx
$xsed "s#https://dify.ai#https://llm.ai#g" ../web/app/components/base/chat/chat-with-history/config-panel/index.tsx
# $xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/share/chat/welcome/index.tsx
# $xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/share/chatbot/welcome/index.tsx
$xsed "s#https://dify.ai#https://llm.ai#g" ../web/app/signin/normalForm.tsx
$xsed "s#https://github.com/langgenius/dify#https://github.com/blockmap/llmai#g" ../web/app/components/header/account-about/index.tsx
# find ../web -name "*.tsx" | xargs grep "\- Dify"
# find ../web -name "*.tsx" | xargs grep "\- Dify" | awk -F':' '{print $1}' | xargs $xsed "s#- Dify#- LLM#g"
find ../web -type f -name "*.ts" -o -name "*.tsx" | xargs grep -E "[ '>\"]Dify[ '<\"\$\`]" | grep -vE "default as Dify |Dify.json|embedded-chatbot/index.tsx"
find ../web -type f -name "*.ts" -o -name "*.tsx" | xargs grep -E "[ '>\"]Dify[ '<\"\$\`]" | grep -vE "default as Dify |Dify.json|embedded-chatbot/index.tsx" | awk -F ':' '{print $1}' | xargs -I@ sh -c "sed -i.bak 's#Dify#LLMAI#g' '@'"
find ../web -type f -name "*.ts" -o -name "*.tsx" | xargs grep -E "https://github.com/langgenius/dify" | grep -vE " default as Dify |Dify.json|embedded-chatbot/index.tsx" | awk -F ':' '{print $1}' | xargs -I@ sh -c "sed -i.bak 's#https://github.com/langgenius/dify#https://github.com/blockmap/llmai#g' '@'"

# custom api:
# $xsed "s#Dify OpenAPI#BlockAI OpenAPI#g" ../api/controllers/service_api/index.py
exit 0
