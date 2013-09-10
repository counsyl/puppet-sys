# == Class: sys::nfs::params
#
# Platform-independent parameters for installing NFS client and/or server.
#
class sys::nfs::params {
  case $::osfamily {
    darwin: {
      # NFS client and server built-in to OS X.
      $client = false
      $server = false
    }
    debian: {
      # Debian splits up NFS into common/server packages.
      $client = 'nfs-common'
      $server = 'nfs-kernel-server'
    }
    redhat: {
      # RedHat has everything in one package.
      $client = 'nfs-utils'
      $server = false
    }
    solaris: {
      # NFS client built into Solaris.
      $client = false
      $server = 'service/file-system/nfs'
      $provider = 'pkg'
    }
    default: {
      fail("Do not know how to install NFS on ${::osfamily}\n")
    }
  }
}
