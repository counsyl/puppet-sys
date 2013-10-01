# == Class: sys::iptables::redis
#
# Sets up Linux firewall rules for hosting a redis server.
#
# === Parameters
#
# [*tcp_port*]
#  The TCP port for redis traffic, defaults to 6379.
#
# [*priority*]
#  The priority for the redis firewall rules, defaults to 100.
#
class sys::iptables::redis(
  $tcp_port = '6379',
  $priority = '100',
){
  firewall { "${priority} allow redis tcp":
    action => 'accept',
    proto  => 'tcp',
    dport  => $tcp_port,
  }
}
