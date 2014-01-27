# == Class: sys::iptables::ldap
#
# This class sets up Linux firewall rules for hosting an LDAP server.
# In other words, this class configures iptables to allow incoming
# connections on TCP ports 389 and 636 (by default).
#
# === Parameters
#
# [*port*]
#  The TCP port for LDAP traffic, defaults to 389.  Set to false to disable
#  LDAP traffic entirely.
#
# [*ldaps_port*]
#  The TCP port for LDAPS traffic, defaults to 636.  Set to false to disable
#  LDAPS traffic entirely.
#
# [*priority*]
#  The priority for the ldap firewall rules, defaults to 100.
#
# [*iniface*]
#  Interface to apply iptables to, default is undefined.
#
class sys::iptables::ldap(
  $port     = '389',
  $ssl_port = '636',
  $priority = '100',
  $source   = undef,
  $iniface  = undef,
){
  if $port {
    firewall { "${priority} allow ldap":
      action  => 'accept',
      proto   => 'tcp',
      dport   => $port,
      iniface => $iniface,
    }
  }

  if $ssl_port {
    firewall { "${priority} allow ldaps":
      action  => 'accept',
      proto   => 'tcp',
      dport   => $ssl_port,
      iniface => $iniface,
    }
  }
}
