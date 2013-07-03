# == Class: sys::unzip::params
#
# Platform-dependent parameters for unzip.
#
class sys::unzip::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $package = 'unzip'
      $path = '/usr/local/bin/unzip'
      $source = $openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $package = 'compress/unzip'
      $path = '/usr/bin/unzip'
      $provider = 'pkg'
    }
    default: {
      $package = 'unzip'
      $path = '/usr/bin/unzip'
    }
  }
}
