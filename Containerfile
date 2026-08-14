FROM ubuntu:26.04 AS source

ADD --checksum=sha256:21b545e303194569d463bf70b2df802ddd86aeccb3f64732fc9b1cb4401dd565 https://dl.acronis.com/u/cyber-desktop-client/acronisconnectclient-1.1-25041.x86_64.deb /tmp/source

RUN dpkg-deb -x /tmp/source /out

FROM ghcr.io/containerpak/gtk3:main

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=source /out /

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    dbus libasound2t64 libfuse2t64 libglib2.0-0 \
    libice6 libnss3 libsecret-1-0 libsm6 libxcb-cursor0 libxkbcommon-x11-0 \
    libxkbfile1 libxss1 xdg-utils && \
    /opt/acronisconnectclient/AppRun --fipsinstall \
      /opt/acronisconnectclient/usr/bin/fips.so \
      /opt/acronisconnectclient/usr/bin/fipsmodule.cnf && \
    cpak-clean-junk
