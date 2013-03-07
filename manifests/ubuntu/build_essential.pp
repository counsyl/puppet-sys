# == Class: sys::ubuntu::build_essential
#
# Installs GCC and kernel headers, the essentials necessary for
# building Ubuntu kernel modules.
#
class sys::ubuntu::build_essential {
  include sys::gcc
  package { 'build-essential':
    ensure  => installed,
    require => Class['sys::gcc'],
  }

  # Debian and Ubuntu have different names for kernel headers package.
  if $::lsbdistid == 'Debian' {
    $kernel_flavor = $::kernelrelease
  } else {
    # Have to extract the "flavor" of the kernel from the $::kernelrelease
    # fact. For example: '2.6.32-40-generic' => 'generic'
    #                    '3.2.0-38-virtual'  => 'virtual'
    $kernel_flavor = regsubst($::kernelrelease, '^.+\-(\w+)$', '\1')
  }
  $kernel_headers = "linux-headers-${kernel_flavor}"

  package { $kernel_headers:
    ensure => installed,
  }
}
