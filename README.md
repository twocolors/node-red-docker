# Node-RED Docker

This project from origanl [Node-RED Docker](https://github.com/node-red/node-red-docker/tree/master/docker-custom) based on **Debian** with dev tools and ffmpeg

This projects i make for support [node-red-contrib-tfjs-coco-ssd](https://flows.nodered.org/node/node-red-contrib-tfjs-coco-ssd) on Raspberry Pi 4, more information in [Issues#2](https://github.com/dceejay/tfjs-coco-ssd/issues/2)

### Architecture
Node-RED Docker is supported by manifest list, which means one doesn't need to specify the tag for a specific architecture. Using the image without any tag or the latest tag, will pull the right image for the architecture required.

Currently, Node-RED Docker has support for multiple architectures:
- `amd64`   : based on linux bookworm-slim - for most desktop computer (e.g. x64, x86-64, x86_64)
- `arm32v7` : based on linux bookworm-slim - (i.e. Raspberry Pi 2, 3, 4)
- `arm64v8` : based on linux bookworm-slim - (i.e. Pine64)

**Note**: Currently there is a not official image NodeJS based on Debian architecture `arm32v6`

### Install

```bash
docker pull ghcr.io/twocolors/node-red-docker
```

### Quick Start

```bash
docker run -it --net=host -v <path_on_host>:/data --name=node-red ghcr.io/twocolors/node-red-docker
```
