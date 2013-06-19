# == Class: sys::perl
#
# Class for installing the Perl language runtime.
#
class sys::perl(
  $ensure  = 'installed',
  $package = 'perl',
) {
  package { $package:
    ensure => $ensure,
  }
}
