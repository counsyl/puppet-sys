# == Class: sys::iptables::puppet
#
# This class sets up Linux firewall rules for hosting a Puppet Master server.
# In other words, this class configures iptables to allow incoming connections
# on TCP port 8140.
#
# === Parameters
#
# [*puppet_port*]
#  This is the TCP port for Puppet, defaults to 8140.
#
# [*priority*]
#  The priority for the puppet firewall rule, defaults to 100.
#
class sys::iptables::puppet(
  $puppet_port = '8140',
  $priority    = '100',
) {
  firewall { "${priority} allow puppet":
    action => 'accept',
    proto  => 'tcp',
    dport  => $puppet_port,
  }
}
