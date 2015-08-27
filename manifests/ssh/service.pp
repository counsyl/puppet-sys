# == Class: sys::ssh::service
#
# Sets up the SSH service.
#
class sys::ssh::service(
  $ensure  = 'running',
  $enable  = true,
  $service = $sys::ssh::params::service,
) inherits sys::ssh::params {

  if $service {
    service { $service:
      ensure  => $ensure,
      enable  => $enable,
      require => Class['ssh::install', 'ssh::config'],
    }
  } elsif $::operatingsystem == 'OpenBSD' {
    # Use this to restart SSH on OpenBSD systems prior to 5.7,
    # which did not have `rcctl`.
    exec { 'openbsd-restart-sshd':
      command     => '/etc/rc.d/sshd restart',
      refreshonly => true,
      subscribe   => File[$sys::ssh::params::sshd_config],
    }
  }
}
