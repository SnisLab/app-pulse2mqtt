# Pulse2MQTT Home Assistant App

Home Assistant packaging for
[SnisLab/pulse2mqtt](https://github.com/SnisLab/pulse2mqtt).

This repository contains no application source. Its workflow downloads the
released Pulse2MQTT binaries and builds the Home Assistant image itself.

Images are published to Docker Hub and GHCR:

```text
docker.io/snislab/app-pulse2mqtt
ghcr.io/snislab/app-pulse2mqtt
```

The `release-built` dispatch from `SnisLab/pulse2mqtt` starts this workflow.
Stable releases publish `latest` and a version tag. Manual edge builds publish
`edge` and a version tag. See `DOCS.md` for configuration details.

The workflow requires `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets. GHCR
publishing uses the repository `GITHUB_TOKEN`.
