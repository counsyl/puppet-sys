# == Class: sys::unzip::params
#
# Platform-dependent parameters for unzip.
#
class sys::unzip::params {
  case $::osfamily {
    darwin: {
      $package = false
      $path = '/usr/bin/unzip'
      $provider = undef
      $source = undef
    }
    openbsd: {
      include sys::openbsd::pkg
      $package = 'unzip'
      $path = '/usr/local/bin/unzip'
      $provider = undef
      $source = $openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $package = 'compress/unzip'
      $path = '/usr/bin/unzip'
      $provider = 'pkg'
      $source = undef
    }
    default: {
      $package = 'unzip'
      $path = '/usr/bin/unzip'
      $provider = undef
      $source = undef
    }
  }
}
