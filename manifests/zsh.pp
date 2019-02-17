# == Class: sys::zsh
#
# Installs the Z shell.
#
class sys::zsh (
  $ensure   = 'installed',
  $package  = $sys::zsh::params::package,
  $source   = $sys::zsh::params::source,
  $provider = $sys::zsh::params::provider,
) inherits sys::zsh::params {
  if $package {
    package { $package:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }
}
