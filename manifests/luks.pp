# == Class: sys::luks
#
# Installs cryptsetup, necessary for LUKS (Linux Unifed Key Setup).
#
class sys::luks(
  $ensure  = 'installed',
  $package = $sys::luks::params::package,
) inherits sys::luks::params {
  package { $package:
    ensure => $ensure,
  }
}
