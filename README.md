# DVBLink TVButler Synology Restore

Recovery notes and helper scripts for restoring a legally owned DVBLogic TVButler / DVBLink TVSource setup on Synology from an old installation backup.

> This repository does **not** contain DVBLogic/DVBLink/TVMosaic proprietary binaries, SPK packages, license files, serial numbers, recordings, passwords, private logs, or extracted application trees.
>
> It documents a recovery procedure for owners of legally purchased DVBLogic TVButler / DVBLink installations who still possess their own backups and license files.

## Tested recovery scenario

- Synology DS216+
- DSM 7.1.1 with Docker
- 2x DVBLogic TVButler 100TC USB DVB-C/T/T2 sticks
- Recovered original Synology package tree from an old WD Blue installation
- DVBLink Server 6.0.0 Build 14499
- DVBLink TVSource 6.0.0 Build 14197
- TVMosaic 1.0.0.17707 used as a parallel verification/fallback instance

## Result

The original DVBLink setup was reconstructed from an old Synology `/volume1/@appstore/DVBLinkServer` tree and the matching `/volume1/DVBLink` share data.

Recovered state:

- DVBLink Server starts in Docker.
- DVBLink TVSource is registered again.
- TVSource-1 and TVSource-2 are present.
- Old DVB-C channels and mappings are present.
- TVButler USB devices are usable again.
- Live TV works through DVBLink/VLC.
- TVMosaic 1.0 can run in parallel as a secondary verification path.

## What is not included

This repository intentionally excludes:

- `*.spk` DVBLogic packages
- `*.lic` license files
- extracted DVBLink/TVMosaic binaries
- old recordings (`*.ts`, `*.mpg`, etc.)
- private logs containing usernames, passwords, serials, local URLs, or tokens
- private certificate keys
- full `tree/`, `share/`, or `DVBLinkServer/` runtime folders

## Required local files

You need your own legally obtained files/backups:

1. DVBLink Server 6.0.0 Synology SPK, for building a base tree.
2. Original old `/volume1/@appstore/DVBLinkServer` directory from the working installation.
3. Original old `/volume1/DVBLink` share directory containing licenses, database, transponders, channel files, etc.
4. TVButler USB sticks.
5. Optional: old DVBLink kernel/firmware stack for forensic reference. Do not blindly load old kernel modules on DSM 7.

## Recovery principle

The key discovery was that the Server SPK alone is not enough. The complete old appstore tree has to be overlaid onto the extracted SPK base tree:

```text
DVBLink Server SPK base tree
+ original /volume1/@appstore/DVBLinkServer tree
+ original /volume1/DVBLink share mounted as target/share
+ /dev/bus/usb passthrough
= restored DVBLink TVSource / TVButler environment
```

## Quick flow

```bash
cd docker
# place your own dvblink-server-synology-linux-x86_64-6_0_0.spk here
# place or mount your own old DVBLinkServer tree outside the repo

./build.sh dvblink-server-synology-linux-x86_64-6_0_0.spk

# Overlay your own recovered old DVBLinkServer tree onto ./tree
rsync -aH --numeric-ids /path/to/old/DVBLinkServer/ ./tree/

# Start with docker compose after adapting paths
cp docker-compose.synology.example.yml docker-compose.synology.yml
# edit volumes to point to your local share/runtime directory
docker build --no-cache -t dvblink:6.0.0 .
docker compose -f docker-compose.synology.yml up -d --force-recreate
```

## Important URLs

Typical ports from the restored setup:

- DVBLink configuration: `http://<synology-ip>:39876`
- DVBLink viewer / streaming: `http://<synology-ip>:8100`
- TVMosaic UI if used in parallel: `http://<synology-ip>:9270`

## Documentation

Start with:

- [docs/01-background.md](docs/01-background.md)
- [docs/02-forensic-findings.md](docs/02-forensic-findings.md)
- [docs/03-restore-procedure.md](docs/03-restore-procedure.md)
- [docs/04-usb-paths.md](docs/04-usb-paths.md)
- [docs/05-troubleshooting.md](docs/05-troubleshooting.md)

## License

The documentation and helper scripts in this repository are released under the MIT License. DVBLogic/DVBLink/TVMosaic are proprietary products and are not included.
