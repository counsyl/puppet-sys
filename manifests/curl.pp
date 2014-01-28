# == Class: sys::curl
#
# Installs the curl, the URL retrieval utility.
#
class sys::curl (
  $ensure   = 'installed',
  $package  = $sys::curl::params::package,
  $provider = $sys::curl::params::provider,
  $source   = $sys::curl::params::source,
) inherits sys::curl::params {
  if $package {
    package { $package:
      ensure   => $ensure,
      provider => $provider,
      source   => $source,
    }
  }
}
