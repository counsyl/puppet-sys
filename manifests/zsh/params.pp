# == Class: sys::zsh::params
#
# Platform-dependent parameters for the Z shell.
#
class sys::zsh::params {
  case $::osfamily {
    darwin: {
      $package = false
      $path    = '/bin/zsh'
    }
    openbsd: {
      include sys::openbsd::pkg
      $package = 'zsh'
      $path    = '/usr/local/bin/zsh'
      $source  = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
      $package  = 'shell/zsh'
      $path     = '/usr/bin/zsh'
    }
    redhat: {
      $package = 'zsh'
      $path    = '/bin/zsh'
    }
    debian: {
      $package = 'zsh'
      $path    = '/bin/zsh'
    }
    default: {
      fail("Don't know how to install bash on ${::osfamily}.\n")
    }
  }
}
