#!/bin/sh
set -eu

BASE="${1:-/volume2/RecoverShare/Recover}"
STAMP=$(date +%F_%H%M)
OUT="$BASE/DVBLink_TVButler_WORKING_$STAMP"
mkdir -p "$OUT"

if [ -d /volume2/docker/dvblink ]; then
  rsync -aH --numeric-ids /volume2/docker/dvblink/ "$OUT/dvblink_runtime/"
fi

if [ -d /volume2/docker/dvblink-build ]; then
  rsync -aH --numeric-ids /volume2/docker/dvblink-build/ "$OUT/dvblink-build/"
fi

if docker ps --format '{{.Names}}' | grep -qx dvblink; then
  docker logs --tail=500 dvblink > "$OUT/docker_dvblink_last500.log" 2>&1 || true
  docker inspect dvblink > "$OUT/docker_inspect_dvblink.json" 2>&1 || true
fi

if docker ps --format '{{.Names}}' | grep -qx tvmosaic; then
  docker logs --tail=500 tvmosaic > "$OUT/docker_tvmosaic_last500.log" 2>&1 || true
  docker inspect tvmosaic > "$OUT/docker_inspect_tvmosaic.json" 2>&1 || true
fi

./check-tvbutler-usb.sh > "$OUT/tvbutler_usb_mapping.txt" 2>&1 || true

echo "$OUT"
