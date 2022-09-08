#!/bin/bash
export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)

echo "#########################################################################"
echo "node-red version: ${NODE_RED_VERSION}"
echo "#########################################################################"

docker build --rm --no-cache \
  --build-arg OS_ARCH=amd64 \
  --build-arg OS_NAME=bullseye-slim \
  --build-arg NODE_VERSION=16 \
  --build-arg NODE_RED_VERSION=${NODE_RED_VERSION} \
  --file Dockerfile \
  --tag twocolors:node-red .