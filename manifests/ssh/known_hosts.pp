# == Class: sys::ssh::known_hosts
#
# This class creates the global SSH known hosts file and makes it
# world-readable, something the Puppet `sshkey` type doesn't do.
#
class sys::ssh::known_hosts inherits sys::ssh::params {
  include sys
  file { $known_hosts:
    ensure => file,
    owner  => 'root',
    group  => $sys::root_group,
    mode   => '0644',
  }
}
