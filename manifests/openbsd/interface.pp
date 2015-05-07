# == Class: sys::openbsd::interface
#
# This class creates `hostname.if` file for the given OpenBSD interface
# name (e.g., the resource name is 'em0').
#
# === Parameters
#
# [*ensure*]
#  The ensure value for the resource, defaults to 'present'.
#
# [*ip*]
#  The IP address to assign to the interface.  Required, unless the
#  interface is for PF logging or synchronization (in other words, the
#  interface name starts with 'pflog' or 'pfsync').
#
# [*addr_family*]
#  The address family to use for the interface, defaults to 'inet' (IPv4).
#  Set to 'inet6' for IPv6.
#
# [*aliases*]
#  A list of IP aliases for the interface, defaults to undef.
#
# [*broadcast*]
#  The broadcast address for the interface, defaults to undef.
#
# [*file*]
#  The location of the interface file, defaults to "/etc/hostname.${title}".
#  Note: changing the location or file permissions/owner is only for
#  testing purposes -- OpenBSD will not recognize an interface that's
#  not put in the default location.
#
# [*flowdst*]
#  The destination IP (and port) for pflow data, defaults to false.
#  Required for pflow devices.
#
# [*flowsrc*]
#  The source IP of pflow data, defaults to false.  Required for pflow devices.
#
# [*group*]
#  The group of the interface file, defaults to 'wheel'.
#
# [*mode*]
#  The mode of the interface file, defaults to '0640'.
#
# [*netmask*]
#  The network mask for the interface, defaults to '255.255.255.0'.
#
# [*pflowproto*]
#  The protocol used for pflow devices, defaults to false.  Set to version
#  you want, e.g., setting to 10 uses IPFIX.
#
# [*owner*]
#  The owner of the interface file ("/etc/hostname.${title}"), defaults
#  to 'root'.
#
# [*template*]
#  The template to use to generate the interface file, defaults to
#  'sys/openbsd/interface.erb'.
#
# === Examples
#
# Here's how to create a DHCP interface for em0:
#
#   sys::openbsd::interface { 'em0':
#     ip => 'dhcp',
#   }
#
# Or, creating a pfsync0 interface using the em1 device:
#
#  sys::openbsd::interface { 'pfsync0':
#    syncdev => 'em1',
#  }
#
# Here's how to create a pflow device, exporting to `10.0.0.8:9995`:
#
#  sys::openbsd::interface { 'pflow0':
#    flowdst => '10.0.0.8:9995',
#    flowsrc => '10.0.0.1',
#  }
#
define sys::openbsd::interface(
  $ensure      = 'present',
  $ip          = undef,
  $addr_family = 'inet',
  $aliases     = [],
  $broadcast   = false,
  $file        = "/etc/hostname.${title}",
  $flowdst     = false,
  $flowsrc     = false,
  $group       = 'wheel',
  $mode        = '0640',
  $netmask     = '255.255.255.0',
  $options     = false,
  $owner       = 'root',
  $pflowproto  = false,
  $syncdev     = false,
  $template    = 'sys/openbsd/interface.erb',
) {

  if $title =~ /^pfsync\d+$/ {
    validate_string($syncdev)
  } elsif $title =~ /^pflow\d+$/ {
    validate_string($flowdst)
    validate_string($flowsrc)
  } else {
    # Fail if an IP address isn't provided for an interface that doesn't
    # use DHCP or is for PF logging.
    if ($title !~ /^pflog\d+$/ and $ip != 'dhcp' and ! is_ip_address($ip)){
      fail('Invalid IP address.')
    }
  }

  validate_re($addr_family, '^inet6?$')
  validate_re($ensure, '^(present|absent)$')
  validate_array($aliases)
  validate_string($netmask)

  if $ensure == 'present' {
    $file_ensure = 'file'
  } else {
    $file_ensure = 'absent'
  }

  file { $file:
    ensure  => $file_ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template($template),
  }
}
