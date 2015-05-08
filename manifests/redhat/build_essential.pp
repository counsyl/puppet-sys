# == Class: sys::redhat::build_essential
#
# Essential build programs for the RedHat platform.
#
class sys::redhat::build_essential {
  include sys::gcc
  include sys::perl

  package { 'kernel-devel':
    ensure  => installed,
    require => Class['sys::gcc'],
  }

  package { 'kernel-headers':
    ensure  => installed,
  }
}
