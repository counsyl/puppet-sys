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
    default: {
      $package = 'sysstat'
    }
  }
}
