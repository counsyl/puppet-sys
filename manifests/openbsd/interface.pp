# == Class: sys::openbsd::interface
#
# This class creates `hostname.if` file for the given OpenBSD interface
# name (e.g., the resource name is 'em0').
#
# === Parameters
#
# [*ip*]
#  The IP address to assign to the interface.  Required, unless the
#  interface is for PF logging (in other words, the interface name
#  starts with 'pflog').
#
# [*addr_family*]
#  The address family to use for the interface, defaults to 'inet' (IPv4).
#  Set to 'inet6' for IPv6.
#
# [*aliases*]
#  A list of IP aliases for the interface.  Defaults to false.
#
# [*broadcast*]
#  The broadcast address for the interface, defaults to false.
#
# [*netmask*]
#  The network mask for the interface, defaults to '255.255.255.0'.
#
# [*owner*]
#  The owner of the interface file ("/etc/hostname.${name}"), defaults
#  to 'root'.
#
# [*group*]
#  The group of the interface file, defaults to 'wheel'.
#
# [*mode*]
#  The mode of the interface file, defaults to '0640'.
#
# [*template*]
#  The template to use to generate the interface file, defaults to
#  'sys/openbsd/interface.erb'.
#
# === Examples
#
# Here's how to create a DHCP interface for em0:
#
#     sys::openbsd::interface { 'em0':
#         ip => 'dhcp',
#     }
define sys::openbsd::interface(
  $ip='',
  $addr_family='inet',
  $aliases=false,
  $broadcast=false,
  $netmask='255.255.255.0',
  $owner='root',
  $group='wheel',
  $mode='0640',
  $template='sys/openbsd/interface.erb',
  ) {

  # Fail if an IP address isn't provided for a non pflog interface.
  if ($ip == '' and $name !~ /^pflog/) {
    fail('Must provide an IP address.\n')
  }

  file { "/etc/hostname.${name}":
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template($template),
  }
}
