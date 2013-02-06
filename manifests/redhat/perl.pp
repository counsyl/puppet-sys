# == Class: sys::redhat::perl
#
# Installs Perl on RedHat platforms.
#
class sys::redhat::perl($package='perl') {
  package { $package:
    ensure => installed,
  }
}
