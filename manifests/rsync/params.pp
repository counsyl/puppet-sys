# == Class: sys::rsync::params
#
# Platform-dependent parameters for rsync.
#
class sys::rsync::params inherits sys {
  $config_file = '/etc/rsyncd.conf'
  $package = 'rsync'
  $service = 'rsync'

  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $provider = undef
      $source = $sys::openbsd::pkg::source
    }
    solaris: {
      include sys::solaris
      $provider = 'pkg'
      $source = undef
    }
    default: {
      $provider = undef
      $source = undef
    }
  }
}
