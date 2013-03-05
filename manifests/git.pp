# == Class: sys::git
#
# Installs git.
#
# === Parameters
#
# All of the parameters are passed to the package provider.
#
class sys::git (
  $ensure   = 'installed',
  $alias    = 'git',
  $package  = $sys::git::params::package,
  $provider = $sys::git::params::provider,
  $source   = $sys::git::params::source,
) inherits sys::git::params {

  # Install the package for git.
  package { $package:
    ensure   => $ensure,
    alias    => $alias,
    provider => $provider,
    source   => $source,
  }

  # Must have the git installed prior to using `vcsrepo` with it.
  if defined('vcsrepo') {
    Package['git'] -> Vcsrepo<| provider == git |>
  }
}
