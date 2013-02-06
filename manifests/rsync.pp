# == Class: sys::rsync
#
# Installs rsync.
#
class sys::rsync (
  $ensure   = "installed",
  $package  = $sys::rsync::params::package,
  $provider = $sys::rsync::params::provider,
  $source   = $sys::rsync::params::source
) inherits sys::rsync::params {
  package { $package:
    ensure   => $ensure,
    provider => $provider,
    source   => $source,
  }
}
