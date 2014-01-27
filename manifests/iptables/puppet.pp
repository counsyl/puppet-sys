# == Class: sys::iptables::puppet
#
# This class sets up Linux firewall rules for hosting a Puppet Master server.
# In other words, this class configures iptables to allow incoming connections
# on TCP port 8140.
#
# === Parameters
#
# [*port*]
#  This is the TCP port for Puppet, defaults to 8140.
#
# [*priority*]
#  The priority for the puppet firewall rule, defaults to 100.
#
# [*iniface*]
#  Interface to apply iptables to, default is undefined.
#
class sys::iptables::puppet(
  $port     = '8140',
  $priority = '100',
  $iniface  = undef,
) {
  firewall { "${priority} allow puppet":
    action  => 'accept',
    proto   => 'tcp',
    dport   => $port,
    iniface => $iniface,
  }
}
