# Node-RED Docker

This project from origanl [Node-RED Docker](https://github.com/node-red/node-red-docker/tree/master/docker-custom) based on **Debian** (slim) with dev tools and [ffmpeg for homebridge](https://github.com/homebridge/ffmpeg-for-homebridge)

This projects i make for support [node-red-contrib-tfjs-coco-ssd](https://flows.nodered.org/node/node-red-contrib-tfjs-coco-ssd) on Raspberry Pi 4, more information in [Issues#2](https://github.com/dceejay/tfjs-coco-ssd/issues/2)

**Note**: Support ARCH `amd64`, `arm32v7`, `arm64v8` and Node.js `14`, `16`, `18`

**Tags:** `14`, `16` is `latest`, `18`

### Install

```bash
docker pull ghcr.io/twocolors/node-red-docker:latest
```

### Quick Start

```bash
docker run -it --net=host -v <path_on_host>:/data --name=node-red ghcr.io/twocolors/node-red-docker:latest
```
