# Troubleshooting

## Products page only shows DVBLink Server, not TVSource

Cause: only the Server SPK was installed/extracted. The old TVSource product registration is missing.

Fix: overlay the complete old `/volume1/@appstore/DVBLinkServer` tree onto the extracted SPK base tree. Verify that `common/product_info/tvsource.xml` and `packages/57c26324-2fd1-4af4-b09d-4333ebff1393/package.xml` exist.

## Sources page only shows XMLTV

Cause: TVSource is not installed/registered in the active tree.

Fix: same as above.

## TVSource appears but says device not present

Cause: old `DevicePath` does not match the current USB topology.

Fix: compare sysfs USB paths and `TVSourceSettings.xml`, then either move the USB sticks or update the paths.

## Tuning fails on early frequencies

Not all old frequencies are still valid. A few failures at low frequencies do not prove a broken tuner. Continue until known-good frequencies are reached. If signal strength and quality appear and services are found, the tuner path works.

## TVMosaic 1.0 works but Plus activation is blocked

This is expected if the old activation infrastructure is unavailable or the local license does not match the current fingerprint. TVMosaic 1.0 can still be useful as a parallel forensic/verification tool if it recognizes TVButler hardware.

## Do not blindly load old kernel modules on DSM 7

Old DVBLink driver modules may have been built for an older DSM kernel, for example `3.10.102`. Loading mismatched `.ko` files on DSM 7 can destabilize the NAS.
