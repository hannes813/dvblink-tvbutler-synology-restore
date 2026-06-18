# Template Dockerfile for a user-owned DVBLink Server 6.0.0 restore.
# This repository does not contain DVBLogic proprietary files.
# Build context must provide a locally extracted ./tree directory created from
# your own SPK and overlaid with your own old DVBLinkServer appstore backup.

FROM debian:stretch-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libc6 libstdc++6 libusb-1.0-0 procps \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/packages/DVBLinkServer
COPY tree/ /var/packages/DVBLinkServer/target/

WORKDIR /var/packages/DVBLinkServer/target

EXPOSE 39876 8100

CMD ["/bin/sh", "-c", "cd /var/packages/DVBLinkServer/target && ./start.sh && tail -f /dev/null"]
