# == Class: sys::screen
#
# Installs GNU screen, the terminal multiplexing tool.
#
# === Parameters
#
# These paramaters are for advanced usage only.
#
# [*ensure*]
#  The ensure value to use for the screen package.  Defaults to 'installed'.
#
# [*package*]
#  The name of the package to install; the default depends on the OS, most
#  likely it is 'screen'.
#
# [*provider*]
#  The provider to use for the package; the default is undef.
#
# [*source*]
#  The source to use for the package; the default is undef.
#
class sys::screen(
  $ensure   = $sys::screen::params::ensure,
  $package  = $sys::screen::params::package,
  $provider = $sys::screen::params::provider,
  $source   = $sys::screen::params::source,
) inherits sys::screen::params {
  package { $package:
    ensure   => $ensure,
    alias    => 'screen',
    provider => $provider,
    source   => $source,
  }
}
