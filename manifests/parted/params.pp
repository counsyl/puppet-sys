# == Class: sys::parted::params
#
# Platform-dependent parameters for installing GNU parted.
#
class sys::parted::params {
  case $::osfamily {
    debian: {
      $package = 'parted'
    }
    redhat: {
      $package = 'parted'
    }
    default: {
      fail("Do not know how to install parted on ${::osfamily}.")
    }
  }
}
