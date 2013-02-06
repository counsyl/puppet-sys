# OS-specific parameters for rsync.
class sys::rsync::params {
  $package = 'rsync'
  case $::operatingsystem {
    openbsd: {
      include openbsd::pkg
      $source = $openbsd::pkg::source
    }
    solaris: {
      if $::operatingsystemrelease < '5.11' {
        fail("rsync only supported on Solaris 5.11 and above.\n")
      }
      $provider = 'pkg'
    }
  }
}
