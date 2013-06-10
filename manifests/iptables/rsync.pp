# == Class: sys::iptables::rsync
#
# Sets up Linux firewall rules for hosting an rsync share.
#
# === Parameters
#
# [*tcp_port*]
#  The TCP port for rsync traffic, defaults to 873.
#
# [*udp_port*]
#  The UDP port for rsync traffic, defaults to 873.
#
# [*priority*]
#  The priority for the rsync firewall rules, defaults to 100.
#
class sys::iptables::rsync(
  $tcp_port = '873',
  $udp_port = '873',
  $priority = '100',
){
  firewall { "${priority} allow rsync tcp":
    action => 'accept',
    proto  => 'tcp',
    dport  => $tcp_port,
  }

  firewall { "${priority} allow rsync udp":
    action => 'accept',
    proto  => 'udp',
    dport  => $udp_port,
  }
}
