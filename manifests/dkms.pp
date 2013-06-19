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

  package { $package:
    ensure => $ensure,
  }
}
