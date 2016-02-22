# == Class: sys::unzip
#
# Installs the unzip extraction utility.
#
class sys::unzip(
  $ensure   = 'installed',
  $package  = $sys::unzip::params::package,
  $source   = $sys::unzip::params::source,
  $provider = $sys::unzip::params::provider,
) inherits sys::unzip::params {
  if $package {
    if !defined(Package[$package]) {
      package { $package:
        ensure   => $ensure,
        alias    => 'unzip',
        provider => $provider,
        source   => $source,
      }
    }
  }
}
