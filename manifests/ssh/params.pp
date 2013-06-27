# == Class: sys::ssh::params
#
# Platform-dependent parameters for SSH.
#
class sys::ssh::params {
  case $::osfamily {
    darwin: {
      $client = false
      $server = false
    }
    openbsd: {
      # Installed by default on OpenBSD
      $client = false
      $server = false
      $service = false
      $sftp_subsystem = '/usr/libexec/sftp-server'
      $use_pam = false
      if versioncmp($::kernalmajversion, '5.0') >= 0 {
        $ecdsa = true
        $sandbox = true
      } else {
        $ecdsa = false
      }
    }
    solaris: {
      if $::operatingsystemrelease < '5.11' {
        fail("SSH module supported only on Solaris 5.11 and above.\n")
      }
      $client = 'network/ssh'
      $server = 'service/network/ssh'
      $provider = 'pkg'
      $service = 'svc:/network/ssh:default'
      $sftp_subsystem = 'internal-sftp'
      $use_pam = false
      $ecdsa = false
    }
    debian: {
      if $::operatingsystem == 'Ubuntu' {
        $lsb_compare = '12'
      } else {
        $lsb_compare = '7'
      }

      if versioncmp($::lsbmajdistrelease, $lsb_compare) >= 0 {
        $ecdsa = true
      } else {
        $ecdsa = false
      }
      
      $client = 'openssh-client'
      $server = 'openssh-server'
      $service = 'ssh'
      $sftp_subsystem = '/usr/lib/openssh/sftp-server'
      # Necessary for motd (seriously) to work.
      $use_pam = true
    }
    redhat: {
      $client = 'openssh-clients'
      $server = 'openssh-server'
      $service = 'sshd'
      $sftp_subsystem = '/usr/libexec/openssh/sftp-server'
      $use_pam = true
      $ecdsa = false
    }
    default: {
      fail("The SSH module is not supported on ${::osfamily}.\n")
    }
  }

  # Configuration file locations.  Macs are the special snowflake here.
  case $::osfamily {
    darwin: {
      $ssh_config  = '/etc/ssh_config'
      $sshd_config = '/etc/sshd_config'
    }
    default: {
      $ssh_config  = '/etc/ssh/ssh_config'
      $sshd_config = '/etc/ssh/sshd_config'
    }
  }
}
