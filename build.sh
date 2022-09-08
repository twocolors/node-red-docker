#!/bin/bash
export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)

echo "#########################################################################"
echo "node-red version: ${NODE_RED_VERSION}"
echo "#########################################################################"

# linux/amd64, linux/arm64, linux/arm/v7, linux/arm/v6

docker build --rm --no-cache \
  --build-arg OS_NAME=bullseye-slim \
  --build-arg NODE_VERSION=16 \
  --build-arg TARGETPLATFORM="linux/amd64" \
  --file Dockerfile \
  --tag twocolors:node-red .
