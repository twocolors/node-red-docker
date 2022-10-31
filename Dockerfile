ARG OS_NAME
ARG NODE_VERSION

### base ###
FROM node:${NODE_VERSION}-${OS_NAME} AS base

# Copy FS
COPY prebuildfs /

ARG TARGETPLATFORM

# Install required system packages and dependencies
RUN set -ex \
  && /opt/docker/bin/install_packages \
      build-essential \
      ca-certificates \
      curl \
      git \
      openssh-client \
      openssl \
      python3 \
      python3-dev \
      tzdata \
      iputils-ping \
      libcap2-bin \
      tar \
      gzip \
      unzip \
      zip \
  # Add user like pi (1000)
  && deluser --remove-home node \
  && useradd --home-dir /usr/src/node-red --uid 1000 node-red \
  && chown -R node-red:root /data && chmod -R g+rwX /data \
  && chown -R node-red:root /usr/src/node-red && chmod -R g+rwX /usr/src/node-red \
  # Add known_hosts
  && /opt/docker/bin/known_hosts /etc/ssh/ssh_known_hosts \
  && echo "PubkeyAcceptedKeyTypes +ssh-rsa" >> /etc/ssh/ssh_config \
  # ffmpeg-for-homebridge
  && case "$TARGETPLATFORM" in \
    linux\/amd64) FFMPEG='debian-x86_64';; \
    linux\/arm/v6) FFMPEG='raspbian-armv6l';; \
    linux\/arm/v7) FFMPEG='debian-armv7l';; \
    linux\/arm64) FFMPEG='debian-aarch64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
    esac \
  && curl -Lfs --connection-timeout 60 --retry 10 --retry-delay 5 https://github.com/oznu/ffmpeg-for-homebridge/releases/latest/download/ffmpeg-${FFMPEG}.tar.gz | tar xzf - -C / --no-same-owner

# Set work directory
WORKDIR /usr/src/node-red

### build ###
FROM base AS build

RUN set -ex \
  && npm install --unsafe-perm --no-update-notifier --no-fund --only=production \
  && npm uninstall node-red-node-gpio \
  && /opt/docker/bin/remove_native_gpio \
  && cp -R node_modules prod_node_modules

### release ###
FROM base AS RELEASE

COPY --from=build /usr/src/node-red/prod_node_modules ./node_modules

RUN set -ex \
  && chown -R node-red:root /usr/src/node-red \
  && npm config set cache /data/.npm --global \
  && npm config set python `which python3` --global \
  # support port 80
  && setcap 'cap_net_bind_service=+ep' `which node`

USER node-red

ENV NODE_PATH=/usr/src/node-red/node_modules:/data/node_modules \
  PATH=/opt/docker/bin:/usr/src/node-red/node_modules/.bin:${PATH} \
  FLOWS=flows.json

EXPOSE 1880

HEALTHCHECK CMD node /usr/src/node-red/healthcheck.js

ENTRYPOINT ["./entrypoint"]