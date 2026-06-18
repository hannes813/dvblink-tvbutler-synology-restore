# Docker restore template

This directory contains templates only. It intentionally does not include the DVBLink SPK, extracted appstore tree, licenses, or runtime share data.

## Build pattern

```bash
./build.sh dvblink-server-synology-linux-x86_64-6_0_0.spk
rsync -aH --numeric-ids /path/to/old/DVBLinkServer/ ./tree/
docker build --no-cache -t dvblink:6.0.0 .
docker compose -f docker-compose.synology.yml up -d --force-recreate
```
