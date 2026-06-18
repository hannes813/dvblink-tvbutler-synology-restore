# Background

DVBLogic discontinued its DVBLink / TVMosaic infrastructure. For owners of legally purchased DVBLogic TVButler and DVBLink TVSource setups, this can turn working hardware into apparent e-waste because activation and package infrastructure are no longer available.

This project documents a successful recovery of a DVBLink TVButler setup from an old Synology disk backup.

## Recovered chronology

- Synology DS216+ was originally installed with a WD Blue disk.
- DVBLogic TVButler 100TC USB sticks were bought later and used with DVBLink Server + TVSource.
- Recordings from July 2017 prove that the setup worked.
- After migration to another disk, DVBLogic reported that the product had already been activated on another system.
- The old WD Blue installation still contained the complete working DVBLink package tree.

## Core lesson

The Server SPK alone was not enough. The breakthrough came from restoring the complete old `/volume1/@appstore/DVBLinkServer` directory together with the matching `/volume1/DVBLink` share data.
