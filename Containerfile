FROM ghcr.io/containerpak/gtk3:main

ARG DEBIAN_FRONTEND=noninteractive

LABEL org.opencontainers.image.source="https://github.com/Containerpak/acronis-connect"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    dbus libasound2t64 libfuse2t64 libglib2.0-0 \
    libice6 libnss3 libsecret-1-0 libsm6 libxcb-cursor0 libxkbcommon-x11-0 \
    libxkbfile1 libxss1 xdg-utils && \
    cpak-clean-junk
