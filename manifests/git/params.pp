# == Class: sys::git::params
#
# Platform-dependent parameters for git.
#
class sys::git::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $package  = 'git'
      $source   = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $package  = 'developer/versioning/git'
      $provider = 'pkg'
    }
    debian: {
      $package  = 'git-core'
    }
    redhat: {
      $package  = 'git-core'
    }
    default: {
      fail("Do not know how to install git on ${::operatingsystem}.\n")
    }
  }
}
