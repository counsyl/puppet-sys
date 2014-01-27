# == Class: sys::parted
#
# Installs GNU Parted, used by Linux systems to manipulate partition tables.
#
# === Parameters
#
# [*ensure*]
#  The ensure value to use for the parted package.  Defaults to 'installed'.
#
# [*package*]
#  The name of the package to install; the default depends on the OS, most
#  likely it is 'parted'.
#
class sys::parted(
  $ensure  = 'installed',
  $package = $sys::parted::params::package,
) inherits sys::parted::params {
  package { $package:
    ensure   => $ensure,
  }
}
