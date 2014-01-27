# == Class: sys::htop
#
# Installs htop, an interactive process viewer for GNU/Linux.
#
# === Parameters
#
# [*ensure*]
#  The ensure value to use for the htop package.  Defaults to 'installed'.
#
# [*package*]
#  The name of the package to install; the default depends on the OS, most
#  likely it is 'htop'.
#
class sys::htop(
  $ensure  = 'installed',
  $package = $sys::htop::params::package,
) inherits sys::htop::params {
  package { $package:
    ensure => $ensure,
  }
}
