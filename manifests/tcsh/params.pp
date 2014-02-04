# == Class: sys::tcsh::params
#
# Platform-dependent parameters for tcsh.
#
class sys::tcsh::params {
  case $::osfamily {
    darwin: {
      $package = false
      $path    = '/bin/tcsh'
    }
    openbsd: {
      include sys::openbsd::pkg
      $package = 'tcsh'
      $path    = '/usr/local/bin/tcsh'
      $source  = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
      $package  = 'shell/tcsh'
      $path     = '/usr/bin/tcsh'
    }
    redhat: {
      $package = 'tcsh'
      $path    = '/bin/tcsh'
    }
    debian: {
      $package = 'tcsh'
      $path    = '/bin/tcsh'
    }
    default: {
      fail("Don't know how to install bash on ${::osfamily}.\n")
    }
  }
}
