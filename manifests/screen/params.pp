# == Class: sys::screen::params
#
# Platform-dependent parameters for installing screen.
#
class sys::screen::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd
      $package = 'screen'
      $source = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $package = 'terminal/screen'
      $provider = 'pkg'
    }
    default: {
      $package = 'screen'
    }
  }
}
