FROM ghcr.io/containerpak/mesa:main

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl dbus libasound2t64 libfuse2t64 libglib2.0-0 \
    libnss3 libsecret-1-0 libxkbcommon-x11-0 libxkbfile1 libxss1 xdg-utils && \
    curl -fsSL https://dl.acronis.com/u/cyber-desktop-client/acronisconnectclient-1.1-25041.x86_64.deb \
      -o /tmp/acronis-connect.deb && \
    echo '21b545e303194569d463bf70b2df802ddd86aeccb3f64732fc9b1cb4401dd565  /tmp/acronis-connect.deb' | sha256sum -c - && \
    dpkg-deb -x /tmp/acronis-connect.deb / && \
    /opt/acronisconnectclient/AppRun --fipsinstall \
      /opt/acronisconnectclient/usr/bin/fips.so \
      /opt/acronisconnectclient/usr/bin/fipsmodule.cnf && \
    cpak-clean-junk
