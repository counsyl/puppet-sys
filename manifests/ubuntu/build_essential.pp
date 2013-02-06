class sys::ubuntu::build-essential {
  include sys::gcc
  package { 'build-essential':
    ensure  => installed,
    require => Class['sys::gcc'],
  }

  # Debian and Ubuntu have different package names for
  # the Linux kernel headers.
  if $::lsbdistid == Debian {
    $kernel_headers = "linux-headers-${kernelrelease}"
  } else {
    $kernel_headers = 'linux-headers-server'
  }

  package { $kernel_headers:
    ensure => installed,
  }
}
