# == Class: sys::redhat::epel
#
# Adds the EPEL repositories to the RedHat-like system.
#
class sys::redhat::epel {
  # Getting the right RPM depending on this RedHat release.
  case $::operatingsystemrelease {
    /^5\.\d+$/: {
      $epel_name = 'epel-release-5-4'
      $epel_rpm  = "http://download.fedoraproject.org/pub/epel/5/i386/${epel_name}.noarch.rpm"
    }
    /^6\.\d+$/: {
      $epel_name = 'epel-release-6-8'
      $epel_rpm  = "http://download.fedoraproject.org/pub/epel/6/i386/${epel_name}.noarch.rpm"
    }
    /^7\.[\d.]+$/: {
      $epel_name = 'epel-release-7-6'
      $epel_rpm  = "http://download.fedoraproject.org/pub/epel/7/x86_64/e/${epel_name}.noarch.rpm"
    }
    default: {
      fail("Do not know how to install EPEL on RedHat release: ${::operatingsystemrelease}.\n")
    }
  }

  package { $epel_name:
    ensure   => installed,
    alias    => 'epel',
    source   => $epel_rpm,
    provider => 'rpm',
  }
}
