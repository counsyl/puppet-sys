# == Class: sys::git
#
# Installs git, the distributed version control system.
#
# === Parameters
#
# [*ensure*]
#  The ensure value for the git package resources, defaults to 'installed'.
#
# [*package*]
#  The name of the git package to install, default is platform-dependent.
#
# [*provider*]
#  The provider for the package resource, default is platform-dependent.
#
# [*source*]
#  The source for the package resource, default is platform-dependent.
#
class sys::git (
  $ensure   = 'installed',
  $package  = $sys::git::params::package,
  $provider = $sys::git::params::provider,
  $source   = $sys::git::params::source,
) inherits sys::git::params {

  # Install the package for git.
  package { $package:
    ensure   => $ensure,
    alias    => 'git',
    provider => $provider,
    source   => $source,
  }

  # Must have the git installed prior to using `vcsrepo` with it.
  if defined('vcsrepo') {
    Package[$package] -> Vcsrepo<| provider == git |>
  }
}
