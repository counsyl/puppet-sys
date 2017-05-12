# == Class: sys::expect::params
#
# Platform-dependent parameters for expect.
#
class sys::expect::params {
  case $::osfamily {
    default: {
      $package = 'expect'
      $path = '/usr/bin/expect'
      $provider = undef
      $source = undef
    }
  }
}
