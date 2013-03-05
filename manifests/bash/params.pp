# == Class: sys::bash::params
#
# Platform-dependent parameters for the bash shell.
#
class sys::bash::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $source   = $sys::openbsd::pkg::source
      $extras   = 'colorls'
      $package  = 'bash'
      $path     = '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/libexec'
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
      $package  = 'shell/bash'
      $path     = $sys::solaris::path
    }
    redhat: {
      $package  = 'bash'
      $path     = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
    }
    debian: {
      $package  = 'bash'
      $path     = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
    }
    default: {
      fail("The bash module is not supported on ${::operatingsystem}.\n")
    }
  }
}
