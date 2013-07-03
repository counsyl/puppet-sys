# == Class: sys::wget::params
#
# Platform-dependent parameters for wget.
#
class sys::wget::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $package = 'wget'
      $path = '/usr/local/bin/wget'
      $source = $openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $package = 'web/wget'
      $path = '/usr/bin/wget'
      $provider = 'pkg'
    }
    default: {
      $package = 'wget'
      $path = '/usr/bin/wget'
    }
  }
}
