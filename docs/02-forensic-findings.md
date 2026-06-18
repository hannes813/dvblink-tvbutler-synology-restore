# Forensic findings

## Working stack

The recovered working stack was not TVMosaic CE. It was:

```text
DVBLink Server 6.0.0 Build 14499
DVBLink TVSource 6.0.0 Build 14197
DVBLogic TVButler DVB-C/T/T2 (100TC)
```

## Key directories

The important old Synology locations were:

```text
/volume1/@appstore/DVBLinkServer
/volume1/DVBLink
/var/packages/DVBLinkServer
```

`/var/packages/DVBLinkServer/target` pointed to:

```text
/volume1/@appstore/DVBLinkServer
```

## Important files in the old appstore tree

```text
common/product_info/tvsource.xml
packages/57c26324-2fd1-4af4-b09d-4333ebff1393/package.xml
config/dvblink_configuration.xml
config/dvblink_settings.xml
sources/TVSource-1/TVSourceSettings.xml
sources/TVSource-2/TVSourceSettings.xml
templates/sources/TVSource/version.dat
web_server/sources/tvsource/
```

## Important share data

```text
DVBLink/licenses/
DVBLink/database/
DVBLink/transponders/
DVBLink/channel_files/
DVBLink/channel_logo/
DVBLink/RecordedTV/
```

## TVSource registration evidence

The restored UI showed:

```text
DVBLink Server   6.0.0 14499  Free
DVBLink TVSource 6.0.0 14197  Registered
```

## Channel evidence

Recovered channel state:

```text
226 available channels
71 selected channels
TVSource-1 and TVSource-2 present
```
