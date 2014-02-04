# == Class: sys::stat::params
#
# Platform-dependent parameters for sysstat.
#
class sys::stat::params {
  case $::osfamily {
    darwin, openbsd, solaris: {
      # Unix-derived systems have iostat built in.
      $package = false
    }
    debian, redhat: {
      $package = 'sysstat'
    }
    default: {
      fail("Don't know how to install sysstat on ${::osfamily}.\n")
    }
  }
}
