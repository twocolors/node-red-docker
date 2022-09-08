# Node-RED Docker

This project from origanl [Node-RED Docker](https://github.com/node-red/node-red-docker/tree/master/docker-custom) based on **Debian** (bullseye-slim) with dev tools and [ffmpeg for homebridge](https://github.com/homebridge/ffmpeg-for-homebridge)

This projects i make for support [node-red-contrib-tfjs-coco-ssd](https://flows.nodered.org/node/node-red-contrib-tfjs-coco-ssd) more [Issues](https://github.com/dceejay/tfjs-coco-ssd/issues/2) on Raspberry Pi 4

Note: Support arch `amd64`, `arm32v7`, `arm64v8` , node `14`, `16`, `18`

### Install

```bash
docker pull ghcr.io/twocolors/node-red-docker:16
```

### Quick Start

```bash
docker run -it --net=host -v <path_on_host>:/data --name=node-red ghcr.io/twocolors/node-red-docker:16
```