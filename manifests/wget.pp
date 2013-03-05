# == Class: sys::wget
#
# Installs the wget, the url retrieval utility.
#
class sys::wget (
  $ensure   = 'installed',
  $alias    = 'wget',
  $package  = $sys::wget::params::package,
  $source   = $sys::wget::params::source,
  $provider = $sys::wget::params::provider,
) inherits sys::wget::params {
  package { $package:
    ensure   => $ensure,
    alias    => $alias,
    provider => $provider,
    source   => $source,
  }
}
