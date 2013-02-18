# == Class: sys::solaris
#
# Module for Solaris 11 and Illumos derivatives (e.g., OpenIndiana, OmniOS).
#
class sys::solaris {
  if $::osfamily != 'Solaris' or versioncmp($::kernelrelease, '5.11') < 0 {
    fail('Only Solaris 11+ and Illumos kernels are supported.\n')
  }

  # Set parameters based on the Solaris kernel version.  Each variant
  # has different paths.
  case $::kernelversion {
    /^omnios/: {
      $illumos = true
      $omnios = true
      $path = '/opt/omni/bin/amd64:/opt/omni/bin:/usr/gnu/bin/amd64:/usr/gnu/bin:/usr/bin/amd64:/usr/bin:/usr/sbin/amd64:/usr/sbin:/sbin'
    }
    /^oi/: {
      $illumos = true
      $openindiana = true
      $path = '/usr/gnu/bin/amd64:/usr/gnu/bin:/usr/bin/amd64:/usr/bin:/usr/sbin/amd64:/usr/sbin:/sbin'
    }
    /^joyent/: {
      $illumos = true
      $smartos = true
      $path = '/usr/bin:/usr/sbin:/smartdc/bin:/opt/local/bin:/opt/local/sbin'
    }
    default: {
      $illumos = false
      $oracle = true
      $path = '/usr/gnu/bin/amd64:/usr/gnu/bin:/usr/bin/amd64:/usr/bin:/usr/X11/bin/amd64:/usr/X11/bin:/usr/sbin/amd64:/usr/sbin:/sbin'
    }
  }
}
