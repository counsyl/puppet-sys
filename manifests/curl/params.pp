# == Class: sys::curl::params
#
# Platform-dependent parameters for curl.
#
class sys::curl::params {
  case $::osfamily {
    darwin: {
      # Curl included by default on OS X.
      $package = false
      $path = '/usr/bin/curl'
    }
    openbsd: {
      include sys::openbsd::pkg
      $package = 'curl'
      $path = '/usr/local/bin/curl'
      $source = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $package = 'web/curl'
      $path = '/usr/bin/curl'
      $provider = 'pkg'
    }
    default: {
      $package = 'curl'
      $path = '/usr/bin/curl'
    }
  }
}
