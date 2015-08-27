# This class installs the Solaris CIFS (SMB) packages for
# windows file sharing, and enables the service.
class sys::solaris::cifs {
  package { 'service/file-system/smb':
    ensure   => installed,
    provider => 'pkg',
  }

  service { 'system/idmap':
    ensure => running,
  }

  service { 'network/smb/client':
    ensure  => running,
    require => Package['service/file-system/smb'],
  }

  service { 'network/smb/server':
    ensure  => running,
    require => Package['service/file-system/smb'],
  }
}
