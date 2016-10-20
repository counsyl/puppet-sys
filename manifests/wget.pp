# == Class: sys::wget
#
# Installs the wget, the url retrieval utility.
#
class sys::wget (
  $ensure   = 'installed',
  $package  = $sys::wget::params::package,
  $provider = $sys::wget::params::provider,
  $source   = $sys::wget::params::source,
) inherits sys::wget::params {
  ensure_packages([$package], {
    ensure   => $ensure,
    alias    => 'wget',
    provider => $provider,
    source   => $source,
  })
}
