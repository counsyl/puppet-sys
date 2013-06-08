# == Class: sys::zsh::params
#
# Platform-dependent parameters for the Z shell.
#
class sys::zsh::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $package  = 'zsh'
      $source   = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
      $package  = 'shell/zsh'
    }
    redhat: {
      $package  = 'zsh'
    }
    debian: {
      $package  = 'zsh'
    }
    default: {
      fail("Don't know how to install bash on ${::osfamily}.\n")
    }
  }
}
