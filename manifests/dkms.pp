# == Class: dkms
#
# Installs the Dynamic Kernel Module Support (DKMS) package.
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
