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
      $sftp_subsystem = '/usr/libexec/sftp-server'
      $use_pam = false

      if versioncmp($::kernelmajversion, '5.0') >= 0 {
        $ecdsa = true
        $sandbox = true
      } else {
        $ecdsa = false
      }

      if versioncmp($::kernelmajversion, '5.5') >= 0 {
        $ed25519 = true
      } else {
        $ed25519 = false
      }

      if versioncmp($::kernelmajversion, '5.7') >= 0 {
        $service = 'sshd'
      } else {
        $service = false
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
      $ed25519 = false
    }
    debian: {
      if $::operatingsystem == 'Ubuntu' {
        $ecdsa_compare = '12'
        $ed25519_compare = '14'
      } else {
        $ecdsa_compare = '7'
        $ed25519_compare = '7'
      }

      # Facter 2.2+ changed lsbmajdistrelease fact, e.g., now returns
      # '12.04' instead of '12' on Ubuntu precise.
      $lsb_major_release = regsubst($::lsbmajdistrelease, '^(\d+).*', '\1')

      # ECDSA supported in Ubuntu 12.04 / Debian 7 and up.
      if versioncmp($lsb_major_release, $ecdsa_compare) >= 0 {
        $ecdsa = true
      } else {
        $ecdsa = false
      }

      # Ed25519 supported in Ubuntu 14.04 / Debian 7 and up.
      if versioncmp($lsb_major_release, $ed25519_compare) >= 0 {
        $ed25519 = true
      } else {
        $ed25519 = false
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
      $ed25519 = false
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

  # Global known hosts should be same across all platforms (except
  # Cygwin, which is another story).
  $etc_ssh = '/etc/ssh'
  $known_hosts = "${etc_ssh}/ssh_known_hosts"
}
