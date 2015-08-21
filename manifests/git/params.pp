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
      $version = '2.5.0'
      $release_tag = "v${version}.windows.1"
      $base_url = "https://github.com/git-for-windows/git/releases/download/${release_tag}/"

      if $::architecture == 'x64' {
        $basename = "Git-${version}-64-bit.exe"
      } else {
        $basename = "Git-${version}-32-bit.exe"
      }

      $package = "Git version ${version}"
      $install_options = ['/VERYSILENT']
      $win_path = 'C:\Program Files\Git\cmd'
    }
    default: {
      fail("Do not know how to install git on ${::osfamily}.\n")
    }
  }
}
