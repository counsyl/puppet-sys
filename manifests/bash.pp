# == Class: sys::bash
#
# This class installs the Bash shell.
#
# === Parameters
#
# [*ensure*]
#  The ensure value for the bash package resources, defaults to 'installed'.
#
# [*package*]
#  The name of the bash package to install, default is platform-dependent.
#
# [*source*]
#  The source for the package resource, default is platform-dependent.
#
# [*provider*]
#  The provider for the package resource, default is platform-dependent.
#
# [*extras*]
#  Any extra packages to install alongside bash, default is platform-dependent.
#
class sys::bash (
  $ensure   = 'installed',
  $package  = $bash::params::package,
  $source   = $bash::params::source,
  $provider = $bash::params::provider,
  $extras   = $bash::params::extras,
) inherits sys::bash::params {
  if $package {
    package { $package:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }
  if $extras {
    package { $extras:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }
}
