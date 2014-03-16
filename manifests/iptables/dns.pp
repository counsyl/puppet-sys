# == Class: sys::iptables::dns
#
# This class sets up Linux firewall rules for hosting a DNS server.
# In other words, this class configures iptables to allow incoming
# connections on TCP and UDP ports 53 (by default).
#
# === Parameters
#
# [*tcp_port*]
#  The TCP port for DNS traffic, defaults to 53.
#
# [*udp_port*]
#  The UDP port for DNS traffic, defaults to 53.
#
# [*priority*]
#  The priority for the dns firewall rules, defaults to 100.
#
# [*iniface*]
#  Interface to apply iptables to, default is undefined.
#
class sys::iptables::dns(
  $tcp_port = '53',
  $udp_port = '53',
  $priority = '100',
  $iniface  = undef,
){
  include sys::iptables

  firewall { "${priority} allow dns tcp":
    action  => 'accept',
    proto   => 'tcp',
    dport   => $tcp_port,
    iniface => $iniface,
  }

  firewall { "${priority} allow dns udp":
    action  => 'accept',
    proto   => 'udp',
    dport   => $udp_port,
    iniface => $iniface,
  }
}
