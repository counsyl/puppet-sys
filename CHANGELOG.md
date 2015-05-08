## 0.9.18 (05/08/2015)

FEATURES:

* Add `sys::openbsd::disk` defined type for partioning and formatting OpenBSD
  disk devices.

IMPROVEMENTS:

* Add support for pflow devices to `sys::openbsd::interface`.
* Clean up `sys::ssh::config` and `sys::ssh::service`.
* Use native service resources for SSH on OpenBSD 5.7+.

BUG FIXES:

* Fix `sys::screen` package parameters for OpenBSD 5.7.

## 0.9.17 (04/08/2015)

IMPROVEMENTS:

* Updates for OpenBSD manifests (GH-4)

BUG FIXES:

* SELinux template location fix from Bill Weiss (GH-5)
