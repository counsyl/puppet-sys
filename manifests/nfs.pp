# == Class: sys::nfs
#
# Installs NFS client programs for the platform.
#
# === Parameters:
#
# [*ensure*]
#  Ensure value for the NFS client package, defaults to installed.
#
# [*package*]
#  The name of the NFS package resource, default is platform-dependent.
#
# [*source*]
#  The source of the NFS package, default is undefined.
#
# [*provider*]
#  The provider of the NFS package, default is platform-dependent (but
#  most likely undefined).
#
class sys::nfs(
  $ensure   = 'installed',
  $package  = $sys::nfs::params::client,
  $source   = $sys::nfs::params::source,
  $provider = $sys::nfs::params::provider,
) inherits sys::nfs::params {
  if $package {
    package { $package:
      ensure   => $ensure,
      source   => $source,
      provider => $provider,
    }
  }
}
