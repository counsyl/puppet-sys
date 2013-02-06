# OS-specific parameters for wget.
class sys::wget::params {
  $package = 'wget'
  case $::osfamily {
    openbsd: {
      include sys::openbsd::pkg
      $source = $openbsd::pkg::source
    }
    solaris: {
      if $::operatingsystemrelease < '5.11' {
        fail("wget only supported on Solaris 5.11 and above.\n")
      }
      $provider = 'pkg'
    }
  }
}
