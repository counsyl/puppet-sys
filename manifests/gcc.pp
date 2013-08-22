# == Class: sys::gcc
#
# Cross-platform module for installing the GNU Compiler Collection (GCC).
#
# === Parameters
#
# [*ensure*]
#  The ensure value for the GCC package resources, defaults to 'installed'.
#
# [*packages*]
#  The packages to install for GCC support, default is platform-dependent.
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
