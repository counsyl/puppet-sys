# == Class: sys::htop::params
#
# Platform-dependent parameters for installing htop.
#
class sys::htop::params {
  case $::osfamily {
    debian: {
      $package = 'htop'
    }
    redhat: {
      $package = 'htop'
    }
    default: {
      fail("Do not know how to install htop on ${::osfamily}.")
    }
  }
}
