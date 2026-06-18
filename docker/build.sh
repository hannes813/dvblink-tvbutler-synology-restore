#!/bin/sh
set -eu

SPK="${1:-}"
if [ -z "$SPK" ] || [ ! -f "$SPK" ]; then
  echo "Usage: $0 /path/to/dvblink-server-synology-linux-x86_64-6_0_0.spk" >&2
  exit 1
fi

rm -rf tree _extract
mkdir -p _extract tree

tar -xf "$SPK" -C _extract

if [ -f _extract/package.tgz ]; then
  tar -xzf _extract/package.tgz -C tree
elif [ -f _extract/package.tar ]; then
  tar -xf _extract/package.tar -C tree
else
  echo "Could not find package.tgz/package.tar inside SPK. Inspect _extract manually." >&2
  exit 2
fi

echo "Extracted base tree to ./tree"
echo "Now overlay your own old /volume1/@appstore/DVBLinkServer tree:"
echo "  rsync -aH --numeric-ids /path/to/old/DVBLinkServer/ ./tree/"
