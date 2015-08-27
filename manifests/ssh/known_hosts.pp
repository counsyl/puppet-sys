# == Class: sys::ssh::known_hosts
#
# This class creates the global SSH known hosts file and makes it
# world-readable, something the Puppet `sshkey` type doesn't do.
#
class sys::ssh::known_hosts inherits sys::ssh::params {
  include sys

  # Have to ensure /etc/ssh exists as it doesn't exist on all
  # platforms (like OS X).
  file { $sys::ssh::params::etc_ssh:
    ensure => directory,
    owner  => 'root',
    group  => $sys::root_group,
    mode   => '0644',
  }

  file { $sys::ssh::params::known_hosts:
    ensure => file,
    owner  => 'root',
    group  => $sys::root_group,
    mode   => '0644',
  }
}
