#!/bin/sh
set -eu

TREE="${1:-/var/packages/DVBLinkServer/target}"

check() {
  if [ -e "$TREE/$1" ]; then
    echo "OK   $1"
  else
    echo "MISS $1"
  fi
}

check common/product_info/tvsource.xml
check packages/57c26324-2fd1-4af4-b09d-4333ebff1393/package.xml
check sources/TVSource-1/TVSourceSettings.xml
check sources/TVSource-2/TVSourceSettings.xml
check config/dvblink_configuration.xml
check config/dvblink_settings.xml
