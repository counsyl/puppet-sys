# == Class: sys::stat
#
# Installs sysstat, which contains various system performance monitoring tools
# like `iostat`.
#
# === Parameters
#
# [*ensure*]
#  The ensure value to use for the sysstat package.  Defaults to 'installed'.
#
# [*package*]
#  The name of the package to install; the default depends on the OS, most
#  likely it is 'sysstat' or false if it's built-in to the OS.
#
class sys::stat(
  $ensure  = 'installed',
  $package = $sys::stat::params::package,
) inherits sys::stat::params {
  if $package {
    package { $package:
      ensure => $ensure,
    }
  }
}
