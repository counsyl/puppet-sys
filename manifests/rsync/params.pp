# == Class: sys::rsync::params
#
# Platform-dependent parameters for rsync.
#
class sys::rsync::params {
  $package = 'rsync'
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $source = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
    }
  }
}
