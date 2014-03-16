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
# [*priority*]
#  The priority for the dhcp firewall rules, defaults to 100.
#
# [*iniface*]
#  Interface to apply iptables to, default is undefined.
#
class sys::iptables::dhcp(
  $udp_ports = '67-68',
  $priority  = '100',
  $iniface   = undef,
){
  include sys::iptables

  firewall { "${priority} allow dhcp udp":
    action  => 'accept',
    proto   => 'udp',
    dport   => $udp_ports,
    iniface => $iniface,
  }
}
