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

# custom with config
$xsed "s#'CAN_REPLACE_LOGO': 'False'#'CAN_REPLACE_LOGO': 'True'#g" ../api/config.py

# custom server
$xsed "s#Dify#LLM AI#g" ../web/i18n/zh-Hans/login.ts
$xsed "s#Dify#LLM AI#g" ../web/app/layout.tsx
$xsed "s#logo-site.png#logo-site-blockai.png#g" ../web/app/components/base/logo/logo-site.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ../web/app/components/header/account-about/index.tsx
$xsed "s#LangGenius, Inc.#BlockAI, Inc.#g" ../web/app/signin/page.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/header/account-about/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/base/chat/chat-with-history/config-panel/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/share/chat/welcome/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/components/share/chatbot/welcome/index.tsx
$xsed "s#https://dify.ai/#https://llm.ai/#g" ../web/app/signin/normalForm.tsx
$xsed "s#https://github.com/langgenius/dify/#https://github.com/blockmap/llmai/#g" ../web/app/components/header/account-about/index.tsx
