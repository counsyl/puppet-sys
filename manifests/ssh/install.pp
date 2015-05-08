# == Class: sys::ssh::install
#
# Installs the SSH client and server packages, if necessary.
#
class sys::ssh::install(
  $ensure   = 'installed',
  $client   = $sys::ssh::params::client,
  $server   = $sys::ssh::params::server,
  $provider = $sys::ssh::params::provider,
) inherits sys::ssh::params {
  if $client {
    package { $client:
      ensure   => $ensure,
      provider => $provider,
    }
  }

  if $server {
    package { $server:
      ensure   => $ensure,
      provider => $provider,
    }
  }
}
