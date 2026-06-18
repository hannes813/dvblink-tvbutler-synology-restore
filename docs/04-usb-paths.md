# USB path handling

DVBLink TVSource can be sensitive to USB topology. Old configurations can store TVButler devices as paths such as:

```text
1:3
1:4
```

On Linux/Synology, the corresponding sysfs paths appear as:

```text
1-3
1-4
```

## Check current TVButler USB mapping

```bash
for d in /sys/bus/usb/devices/1-*; do
  if [ -f "$d/idVendor" ] && grep -qi "^1d19$" "$d/idVendor"; then
    echo "$(basename "$d") serial=$(cat "$d/serial" 2>/dev/null)"
  fi
done
```

Example working mapping:

```text
1-3 serial=AF0102020700000
1-4 serial=AF0102020700001
```

## Compare with TVSourceSettings

```bash
grep -RIn "<DevicePath>" /var/packages/DVBLinkServer/target/sources/TVSource-*/TVSourceSettings.xml
```

If the current paths do not match, either move the sticks to the expected physical USB ports or update `DevicePath` in the corresponding `TVSourceSettings.xml`.

## Persist changes

If the appstore tree is baked into a Docker image, update both:

```text
running container path: /var/packages/DVBLinkServer/target/sources/...
build tree path:      /volume2/docker/dvblink-build/tree/sources/...
```
