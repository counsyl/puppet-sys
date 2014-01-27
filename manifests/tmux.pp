# == Class: sys::tmux
#
# Installs tmux, the terminal multiplexer.
#
# === Parameters
#
# [*ensure*]
#  The ensure value to use for the tmux package.  Defaults to 'installed'.
#
# [*package*]
#  The name of the package to install; the default depends on the OS, most
#  likely it is 'tmux'.
#
# [*provider*]
#  The provider to use for the package; this is undefined by default.
#
# [*source*]
#  The source to use for the package; the default is undef.
#
class sys::tmux(
  $ensure   = 'installed',
  $package  = $sys::tmux::params::package,
  $provider = $sys::tmux::params::provider,
  $source   = $sys::tmux::params::source,
) inherits sys::tmux::params {
  # Only install if there's actually a package (e.g., tmux is installed
  # by default on OpenBSD).
  if $package {
    package { $package:
      ensure   => $ensure,
      alias    => 'tmux',
      provider => $provider,
      source   => $source,
    }
  }
}
