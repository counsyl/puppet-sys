# == Class: sys::wget::params
#
# Platform-dependent parameters for wget.
#
class sys::wget::params {
  $package = 'wget'
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $source = $openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
    }
  }
}
