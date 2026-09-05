ARG TARGETARCH
ARG BUILD_FROM=ghcr.io/home-assistant/base:3.24
ARG PULSE2MQTT_IMAGE=ghcr.io/snislab/pulse2mqtt:0.4.0

FROM ${PULSE2MQTT_IMAGE} AS pulse2mqtt

FROM ${BUILD_FROM} AS base

FROM base AS base-amd64
ENV HA_ARCH=amd64

FROM base AS base-arm64
ENV HA_ARCH=aarch64

FROM base-${TARGETARCH}

ARG BUILD_VERSION=dev
ARG PULSE2MQTT_IMAGE

COPY --from=pulse2mqtt /usr/local/bin/pulse2mqtt /usr/bin/pulse2mqtt
COPY rootfs /

RUN chmod 0755 \
    /usr/bin/pulse2mqtt \
    /etc/services.d/pulse2mqtt/run \
    /etc/services.d/pulse2mqtt/finish

LABEL \
    io.hass.name="Pulse2MQTT" \
    io.hass.description="Read a Tibber Pulse and publish its measurements over MQTT" \
    io.hass.type="app" \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.arch="${HA_ARCH}" \
    org.opencontainers.image.source="https://github.com/SnisLab/app-pulse2mqtt" \
    org.opencontainers.image.base.name="${PULSE2MQTT_IMAGE}" \
    org.opencontainers.image.licenses="MIT"
