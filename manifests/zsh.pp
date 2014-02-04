# == Class: sys::zsh
#
# Installs the Z shell.
#
class sys::zsh (
  $ensure   = 'installed',
  $package  = $zsh::params::package,
  $source   = $zsh::params::source,
  $provider = $zsh::params::provider,
) inherits sys::zsh::params {
  if $package {
    package { $package:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }
}
