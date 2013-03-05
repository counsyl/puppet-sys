# == Class: sys::gcc::params
#
# Platform-dependent parameters for GCC.
#
class sys::gcc::params {
  case $::osfamily {
    openbsd: {
      # GCC included by default on OpenBSD.
      $packages = false
    }
    solaris: {
      $packages = ['developer/gnu']
    }
    debian: {
      $packages = ['gcc', 'g++', 'make']
    }
    redhat: {
      $packages = ['gcc', 'gcc-c++', 'make']
    }
    default: {
      fail("Do not know how to install/configure GCC on ${::osfamily}.\n")
    }
  }
}
