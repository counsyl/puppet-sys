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
    ensure_packages([$package],
      {
        'ensure'   => 'present',
        'alias'    => 'unzip',
        'provider' => $provider,
        'source'   => $source,
      }
    )
  }
}
