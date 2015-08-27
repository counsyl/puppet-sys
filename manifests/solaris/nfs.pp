# This class ensures Solaris packages/services for NFS are installed.
class sys::solaris::nfs {
  # Ensure NFS is installed and enabled.
  package { 'service/file-system/nfs':
    ensure   => installed,
    provider => 'pkg',
  }

  service { 'network/nfs/server:default':
    ensure  => running,
    require => Package['service/file-system/nfs'],
  }
}
