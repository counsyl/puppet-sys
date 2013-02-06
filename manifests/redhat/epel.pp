# == Class: sys::redhat::epel
#
# Adds the EPEL repositories to the RedHat-like system.
#
class sys::redhat::epel {
  # Getting the right RPM depending on this RedHat release.
  case $operatingsystemrelease {
    /5\.*/: {
      $epel_name = 'epel-release-5-4'
      $epel_rpm  = "http://download.fedora.redhat.com/pub/epel/5/i386/${epel_name}.noarch.rpm"
    }
    /6\.*/: {
      $epel_name = 'epel-release-6-5'
      $epel_rpm  = "http://download.fedora.redhat.com/pub/epel/6/i386/${epel_name}.noarch.rpm"
    }
    default: {
      fail("Do not know how to install EPEL on RedHat release: ${operatingsystemrelase}.\n")
    }
  }

  package { $epel_name:
    alias    => 'epel',
    ensure   => installed,
    source   => $epel_rpm,
    provider => 'rpm',
  }
}
