# == Class: sys::openbsd::pkg
#
# Sets up the OpenBSD package configuration file (/etc/pkg.conf).
#
# Note: A node must be initialized with the `puppet::openbsd` class,
# by itself, before anything in here will actually work.  See:
#  http://projects.puppetlabs.com/issues/8435
#
class sys::openbsd::pkg (
  $config = '/etc/pkg.conf',
  $source = $sys::openbsd::params::mirror,
) inherits sys::openbsd::params {

  # `/etc/pkg.conf` sets settings system-wide for the `pkg_*`
  # utilities on OpenBSD; it eliminates the need for setting
  # PKG_PATH environment variable.
  file { $config:
    ensure  => file,
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => "# OpenBSD pkg.conf\ninstallpath=${source}\n",
  }

  # Ensure the file is in place for OpenBSD's package provider.
  File[$config] -> Package <| |>
}
