# == Class: sys::openbsd::params
#
# Release-dependent parameters for OpenBSD.
#
class sys::openbsd::params {
  # The default mirror for OpenBSD packages.
  $mirror = "http://ftp3.usa.openbsd.org/pub/OpenBSD/${::kernelmajversion}/packages/${::architecture}/"
}
