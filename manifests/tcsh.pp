# == Class: sys::tcsh
#
# Installs the "tee" shell (tcsh).
#
class sys::tcsh (
  $ensure   = 'installed',
  $package  = $tcsh::params::package,
  $source   = $tcsh::params::source,
  $provider = $tcsh::params::provider,
) inherits sys::tcsh::params {
  if $package {
    package { $package:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }
}
