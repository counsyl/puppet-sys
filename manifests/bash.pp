# == Class: sys::bash
#
# This class installs the Bash shell.
#
class sys::bash (
  $ensure   = 'installed',
  $alias    = 'bash',
  $package  = $bash::params::package,
  $source   = $bash::params::source,
  $provider = $bash::params::provider,
  $extras   = $bash::params::extras,
) inherits sys::bash::params {
  package { $package:
    ensure   => $ensure,
    alias    => $alias,
    source   => $source,
    provider => $provider,
  }
  if $extras {
    package { $extras:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }
}
