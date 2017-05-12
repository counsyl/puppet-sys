# == Class: sys::expect
#
# Installs expect, programmed dialogue with interactive programs
#
class sys::expect (
  $ensure   = 'installed',
  $package  = $sys::expect::params::package,
  $provider = $sys::expect::params::provider,
  $source   = $sys::expect::params::source,
) inherits sys::expect::params {
  ensure_packages([$package], {
    ensure   => $ensure,
    alias    => 'expect',
    provider => $provider,
    source   => $source,
  })
}
