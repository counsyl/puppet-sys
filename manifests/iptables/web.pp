# == Class: sys::iptables::web
#
# This class sets up Linux firewall rules for hosting a web server.
# In other words, this class configures iptables to allow incoming
# connections on TCP ports 80 and 443 (by default).
#
# === Parameters
#
# [*http_port*]
#  The TCP port for HTTP traffic, defaults to 80.  Set to false to disable
#  HTTP traffic entirely.
#
# [*https_port*]
#  The TCP port for HTTPS traffic, defaults to 443.  Set to false to disable
#  HTTPS traffic entirely.
#
# [*priority*]
#  The priority for the web firewall rules, defaults to 100.
#
# [*iniface*]
#  Interface to apply iptables to, default is undefined.
#
class sys::iptables::web(
  $http_port  = '80',
  $https_port = '443',
  $priority   = '100',
  $iniface    = undef,
){
  include sys::iptables

  if $http_port {
    firewall { "${priority} allow http":
      action  => 'accept',
      proto   => 'tcp',
      dport   => $http_port,
      iniface => $iniface,
    }
  }

  if $https_port {
    firewall { "${priority} allow https":
      action  => 'accept',
      proto   => 'tcp',
      dport   => $https_port,
      iniface => $iniface,
    }
  }
}
