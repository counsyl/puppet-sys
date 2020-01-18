# == Class: sys::redhat::epel
#
# Adds the EPEL repositories to the RedHat-like system.
#
class sys::redhat::epel {
  # Getting the right RPM depending on this RedHat release.
  case $::operatingsystemmajrelease {
    /^[5-7]$/: {
      $epel_rpm  = "http://dl.fedoraproject.org/pub/epel/epel-release-latest-${operatingsystemmajrelease}.noarch.rpm"
    }
    default: {
      fail("Do not know how to install EPEL on RedHat release: ${::operatingsystemmajrelease}.\n")
    }
  }

  package { 'epel-release':
    ensure   => installed,
    alias    => 'epel',
    source   => $epel_rpm,
    provider => 'rpm',
  }
}
