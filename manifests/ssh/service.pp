# == Class: sys::ssh::service
#
# Sets up the SSH service.
#
class sys::ssh::service(
  $ensure  = 'running',
  $service = $sys::ssh::params::service,
) inherits sys::ssh::params {

  if $service {
    service { $service:
      ensure     => $ensure,
      alias      => 'ssh',
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      require    => [ Class['ssh::install'], Class['ssh::config'] ],
    }
  }
  if $::operatingsystem == 'OpenBSD' and $::kernelversion >= '5.0' {
    # Use this to restart SSH on OpenBSD 5.0 systems (which have
    # rc.d scripts for SSH).
    exec { "openbsd-restart-sshd":
      command     => "/etc/rc.d/sshd restart",
      subscribe   => File['sshd_config'],
      refreshonly => true,
    }
  }
}
