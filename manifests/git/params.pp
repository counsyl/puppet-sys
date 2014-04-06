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
    windows: {
      $version = '1.9.0-preview20140217'
      $basename = "Git-${version}.exe"
      $package = "Git version ${version}"
      $install_options = ['/VERYSILENT']
      $base_url = 'http://msysgit.googlecode.com/files/'
      if $::architecture == 'x64' {
        $win_path = 'C:\Program Files (x86)\Git\cmd'
      } else {
        $win_path = 'C:\Program Files\Git\cmd'
      }
    }
    default: {
      fail("Do not know how to install git on ${::osfamily}.\n")
    }
  }
}
