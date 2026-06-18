# Restore procedure

This procedure documents the successful recovery pattern. It assumes that you have your own legally obtained DVBLink files and backups.

## 1. Build base tree from SPK

```bash
cd /volume2/docker/dvblink-build
./build.sh dvblink-server-synology-linux-x86_64-6_0_0.spk
```

This extracts a server-only tree.

## 2. Overlay old appstore tree

Find the old appstore tree by locating `common/product_info/tvsource.xml`:

```bash
SRC_FILE=$(find /volume1 /volume2 -type f \
  -path "*DVBLinkServer/common/product_info/tvsource.xml" \
  2>/dev/null | head -1)
SRC="${SRC_FILE%/common/product_info/tvsource.xml}"
echo "$SRC"
```

Overlay it onto the extracted base tree:

```bash
rsync -aH --numeric-ids --info=progress2 \
  "$SRC"/ \
  /volume2/docker/dvblink-build/tree/
```

## 3. Verify TVSource is present

```bash
test -f /volume2/docker/dvblink-build/tree/common/product_info/tvsource.xml && echo "TVSource product_info OK"
test -f /volume2/docker/dvblink-build/tree/packages/57c26324-2fd1-4af4-b09d-4333ebff1393/package.xml && echo "TVSource package OK"
test -f /volume2/docker/dvblink-build/tree/sources/TVSource-1/TVSourceSettings.xml && echo "TVSource-1 OK"
test -f /volume2/docker/dvblink-build/tree/sources/TVSource-2/TVSourceSettings.xml && echo "TVSource-2 OK"
```

## 4. Mount the old share data

The Docker runtime should mount the restored DVBLink share into:

```text
/var/packages/DVBLinkServer/target/share
```

On the host this was typically:

```text
/volume2/docker/dvblink/share
```

It should contain folders like `licenses`, `database`, `transponders`, `channel_files`, and `RecordedTV`.

## 5. Build and start

```bash
docker build --no-cache -t dvblink:6.0.0 .
docker compose -f docker-compose.synology.yml up -d --force-recreate
```

## 6. Verify

Open:

```text
http://<synology-ip>:39876/products/
```

Expected:

```text
DVBLink Server 6.0.0 Build 14499
DVBLink TVSource 6.0.0 Build 14197 Registered
```

Then open sources:

```text
http://<synology-ip>:39876/c/sources/show/
```

Expected:

```text
TVSource-1
TVSource-2
DVBLogic TVButler DVB-C/T/T2 (100TC)
```
