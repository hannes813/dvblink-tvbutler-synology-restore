# Current working state template

Fill this file after a successful restore.

## Containers

```text
dvblink   dvblink:6.0.0                  Up ...
tvmosaic  dvblogic/tvmosaic:1.0.0.17707  Up ...
```

## URLs

```text
DVBLink configuration: http://<synology-ip>:39876
DVBLink viewer:        http://<synology-ip>:8100
TVMosaic:              http://<synology-ip>:9270
```

## USB mapping

```text
1-3 serial=<redacted>
1-4 serial=<redacted>
```

## Product state

```text
DVBLink Server   6.0.0 14499  Free
DVBLink TVSource 6.0.0 14197  Registered
```

## Functional tests

- [ ] DVBLink products page shows TVSource registered
- [ ] TVSource-1 and TVSource-2 visible
- [ ] Channel list visible
- [ ] Live TV starts in VLC/browser
- [ ] Test recording creates a `.ts` file
- [ ] Backup of working state created
