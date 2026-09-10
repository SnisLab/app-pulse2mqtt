ARG TARGETARCH
ARG BUILD_FROM=ghcr.io/home-assistant/base:3.24

FROM ${BUILD_FROM} AS base

FROM base AS base-amd64
ENV HA_ARCH=amd64

FROM base AS base-arm64
ENV HA_ARCH=aarch64

FROM base-${TARGETARCH}

ARG BUILD_VERSION=dev

COPY binaries/ /tmp/pulse2mqtt-binaries/
COPY rootfs /

RUN install -D -m 0755 "/tmp/pulse2mqtt-binaries/${TARGETARCH}/pulse2mqtt" /usr/bin/pulse2mqtt \
    && chmod 0755 \
    /etc/services.d/pulse2mqtt/run \
    /etc/services.d/pulse2mqtt/finish \
    && rm -rf /tmp/pulse2mqtt-binaries

LABEL \
    io.hass.name="Pulse2MQTT" \
    io.hass.description="Read a Tibber Pulse and publish its measurements over MQTT" \
    io.hass.type="app" \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.arch="${HA_ARCH}" \
    org.opencontainers.image.source="https://github.com/SnisLab/app-pulse2mqtt" \
    org.opencontainers.image.licenses="MIT"
