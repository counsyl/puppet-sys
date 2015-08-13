# == Class: sys::iptables::dhcp
#
# This class sets up Linux firewall rules for hosting a DHCP server.
# In other words, this class configures iptables to allow incoming
# connections on UDP ports 67 and 68 (by default).
#
# === Parameters
#
# [*udp_ports*]
#  The UDP port range for DHCP traffic, defaults to '67-68'.
#
# [*iniface*]
#  Interface for firewall resources, default is undefined.
#
# [*priority*]
#  The priority for the dhcp firewall rules, defaults to 100.
#
# [*source*]
#  Source for firewall resources, default is undefined.
#
class sys::iptables::dhcp(
  $udp_ports = '67-68',
  $iniface   = undef,
  $priority  = '100',
  $source    = undef,
){
  include sys::iptables

  firewall { "${priority} allow dhcp udp":
    action  => 'accept',
    proto   => 'udp',
    dport   => $udp_ports,
    iniface => $iniface,
    source  => $source,
  }
}
