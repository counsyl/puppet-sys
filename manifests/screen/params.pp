# == Class: sys::screen::params
#
# Platform-dependent parameters for installing screen.
#
class sys::screen::params {
  case $::osfamily {
    openbsd: {
      include sys::openbsd
      if versioncmp($::kernelmajversion, '5.3') >= 0 {
        $package = 'screen-4.0.3p3'
      } else {
        $package = 'screen-4.0.3p2'
      }
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
