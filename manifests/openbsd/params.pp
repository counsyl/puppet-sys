# == Class: sys::openbsd::params
#
# Release-dependent parameters for OpenBSD.
#
class sys::openbsd::params {
  # The default mirror for OpenBSD packages.
  $mirror = "http://ftp3.usa.openbsd.org/pub/OpenBSD/${::kernelmajversion}/packages/${::architecture}/"

  # Certain OpenBSD packages, like Emacs and Python, have specific version
  # strings that we need to use for `ensure`.  Also used to specify what
  # version Puppet and Facter are packaged for the kernel version.
  case $::kernelmajversion {
    '5.2': {
      $emacs  = '22.3p13'
      $python = '2.7.3p0'
      $ruby   = 'ruby-1.8.7.370'
      $puppet = '2.7.14'
      $facter = '1.6.8'
    }
    '5.1': {
      $emacs  = '22.3p12'
      $python = '2.7.1p12'
      $ruby   = '1.8.7.357'
      $puppet = '2.7.5'
      $facter = '1.6.0'
    }
    '5.0': {
      $emacs  = '22.3p10'
      $python = '2.7.1p9'
      $ruby   = '1.8.7.352p1'
      $puppet = '2.7.1'
      $facter = '1.6.0'
    }
    default: {
      fail("Unsupported version of OpenBSD: ${::kernelmajversion}.\n")
    }
  }
}
