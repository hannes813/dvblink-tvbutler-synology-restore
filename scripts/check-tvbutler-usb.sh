#!/bin/sh
set -eu

echo "=== TVButler sysfs mapping ==="
for d in /sys/bus/usb/devices/1-*; do
  if [ -f "$d/idVendor" ] && grep -qi "^1d19$" "$d/idVendor"; then
    echo "$(basename "$d") serial=$(cat "$d/serial" 2>/dev/null || true)"
  fi
done

echo
echo "=== lsusb tree ==="
lsusb -t 2>/dev/null || true

echo
echo "=== proc usb detail ==="
cat /proc/bus/usb/devices 2>/dev/null | grep -iE "Vendor=1d19|ProdID=0100|SerialNumber|Product=TS Aggregator" -B6 -A4 || true
