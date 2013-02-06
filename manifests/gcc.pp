# == Class: sys::gcc
#
# Cross-platform module for installing the GNU Compiler Collection (GCC).
#
class sys::gcc (
  $ensure   = 'installed',
  $packages = $sys::gcc::params::packages
) inherits sys::gcc::params {
  if $packages {
    package { $packages:
      ensure => $ensure,
    }
  }
}
