# == Class: ssh::config
#
# Creates the SSH daemon and client configuration files.
#
class sys::ssh::config(
  $sshd_config   = $sys::ssh::params::sshd_config,
  $sshd_template = 'sys/ssh/sshd_config.erb',
  $mode          = '0600',
) inherits sys::ssh::params {

  include sys

  if $sys::ssh::privilege_separation {
    # OpenSSH 5.0+ can take 'sandbox' as a value for more secure
    # privilege separation.
    if $sys::ssh::params::sandbox {
      $privilege_separation = 'sandbox'
    } else {
      $privilege_separation = 'yes'
    }
  } else {
    $privilege_separation = 'no'
  }

  file { $sshd_config:
    ensure  => file,
    owner   => 'root',
    group   => $sys::root_group,
    mode    => $mode,
    content => template($sshd_template),
    notify  => Class['ssh::service'],
    require => Class['ssh::install'],
  }
}
