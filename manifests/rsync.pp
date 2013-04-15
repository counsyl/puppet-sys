# == Class: sys::rsync
#
# Installs rsync.
#
class sys::rsync (
  $ensure   = 'installed',
  $package  = $sys::rsync::params::package,
  $provider = $sys::rsync::params::provider,
  $source   = $sys::rsync::params::source,
) inherits sys::rsync::params {
  # Install the rsync package.
  package { $package:
    ensure   => $ensure,
    alias    => 'rsync',
    provider => $provider,
    source   => $source,
  }
}
