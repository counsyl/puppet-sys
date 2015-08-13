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
# [*iniface*]
#  Interface for firewall resources, default is undefined.
#
# [*priority*]
#  The priority for the web firewall rules, defaults to 100.
#
# [*source*]
#  Source for firewall resources, default is undefined.
#
class sys::iptables::web(
  $http_port  = '80',
  $https_port = '443',
  $iniface    = undef,
  $priority   = '100',
  $source     = undef,
){
  include sys::iptables

  if $http_port {
    firewall { "${priority} allow http":
      action  => 'accept',
      proto   => 'tcp',
      dport   => $http_port,
      iniface => $iniface,
      source  => $source,
    }
  }

  if $https_port {
    firewall { "${priority} allow https":
      action  => 'accept',
      proto   => 'tcp',
      dport   => $https_port,
      iniface => $iniface,
      source  => $source,
    }
  }
}
