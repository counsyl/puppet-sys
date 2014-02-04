# == Class: sys::bash::params
#
# Platform-dependent parameters for the bash shell.
#
class sys::bash::params {
  case $::osfamily {
    darwin: {
      # Bash is included by default on OS X.
      $package = false
      $path    = '/bin/bash'
      $defpath = '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin'
    }
    openbsd: {
      include sys::openbsd::pkg
      $source  = $sys::openbsd::pkg::source
      $extras  = 'colorls'
      $package = 'bash'
      $path    = '/usr/local/bin/bash'
      $defpath = '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/libexec'
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
      $package  = 'shell/bash'
      $path     = '/usr/bin/bash'
      $defpath  = $sys::solaris::path
    }
    redhat: {
      $package  = 'bash'
      $path     = '/bin/bash'
      $defpath  = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
    }
    debian: {
      $package  = 'bash'
      $path     = '/bin/bash'
      $defpath  = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
    }
    default: {
      fail("Don't know how to install bash on ${::osfamily}.\n")
    }
  }
}
