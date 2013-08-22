# == Class: sys::dkms
#
# Installs the Dynamic Kernel Module Support (DKMS) package.
#
# === Parameters
#
# [*ensure*]
#  The ensure value for the DKMS package resource, defaults to 'installed'.
#
# [*package*]
#  The name of the DKMS package, defaults to 'dkms'.
#
class sys::dkms(
  $ensure  = 'installed',
  $package = 'dkms',
){
  if $::kernel != 'Linux' {
    fail("DKMS support is only for Linux kernels.\n")
  }

  if $::osfamily == 'RedHat' {
    # DKMS is in EPEL.
    include sys::redhat::epel
    Class['sys::redhat::epel'] -> Package[$package]
  }

  package { $package:
    ensure => $ensure,
  }
}
