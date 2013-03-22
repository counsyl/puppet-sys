# == Class: sys::iptables::web
#
# This class sets up Linux firewall rules for hosting a web server.
# In other words, this class configures iptables to allow incoming
# connections on TCP ports 80 and 443 (by default).
#
# === Parameters
#
# [*http*]
#  Whether or not to allow HTTP traffic, defaults to true.
#
# [*http_port*]
#  The TCP port for HTTP traffic, defaults to 80.
#
# [*https*]
#  Whether or not to allow HTTPS traffic, defaults to true.
#
# [*https_port*]
#  The TCP port for HTTPS traffic, defaults to 443.
#
# [*priority*]
#  The priority for the web firewall rules, defaults to 100.
#
class sys::iptables::web(
  $http       = true,
  $http_port  = '80',
  $https      = true,
  $https_port = '443',
  $priority   = '100',
){

  if $http {
    firewall { "${priority} allow http":
      action => 'accept',
      proto  => 'tcp',
      dport  => $http_port,
      notify => Exec['persist-firewall'],
    }
  }

  if $https {
    firewall { "${priority} allow https":
      action => 'accept',
      proto  => 'tcp',
      dport  => $https_port,
      notify => Exec['persist-firewall'],
    }
  }
}
