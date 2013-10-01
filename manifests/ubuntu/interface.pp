# == Define: sys::ubnutu::interface
#
# Simple resource type for declaring a _single_ network interface
# (with the default template) on Ubuntu.  The name of the resource
# is the network device name.  On newer distributions (12.04), this can
# also be used to configure the DNS (in other words, the keyword
# parameters in`/etc/resolv.conf`).  The `resolvconf` specific keywords
# are $nameserver, $domain, $search, and $sortlist.
#
# === Parameters
#
# [*ip*]
#   Either 'dhcp' or the static IP address of the network interface.
#
# [*gateway*]
#   The network gateway IP address (only used for static IPs).
#
# [*domain*]
#   The DNS domain to use; defaults to false.  This option is mutually
#   exclusive of the `search` parameter.
#
# [*nameserver*]
#   The DNS nameserver(s) to use; defaults to false.  May use a string
#   or an array of the IP addresses to use for nameservers.
#
# [*netmask*]
#   The netmask of the interface, defaults to '255.255.255.0'.
#
# [*search*]
#   The DNS search domain(s) to use; defaults to false.  May use a string
#   or an array of the DNS search domains.
#
# [*sortlist*]
#   The DNS sorting list to use in resolv.conf; defaults to false. May
#   use a string or an array of the DNS sorting list.
#
# [*template*]
#   Template file to use for creating the network interface file.
#   Defaults to 'ubuntu/interface.erb'.
#
# === Examples
#
# Dynamically get network information for eth0:
#
#   sys::ubuntu::interface { 'eth0':
#     ip => 'dhcp',
#   }
#
# Assign a static IP to eth0:
#
#   sys::ubuntu::interface { 'eth0':
#     ip      => '192.168.1.100',
#     gateway => '192.168.1.1',
#   }
#
define sys::ubuntu::interface(
  $ip,
  $gateway    = undef,
  $nameserver = undef,
  $domain     = undef,
  $search     = undef,
  $netmask    = '255.255.255.0',
  $sortlist   = undef,
  $template   = 'sys/ubuntu/interface.erb'
){
  $device = $name
  warning("This type is deprecated, use the `sys::ubuntu::network` class.\n")

  if ($ip != 'dhcp') and ($gateway == undef) {
    fail("Must provide a gateway for a static IP address.\n")
  }

  file { '/etc/network/interfaces':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
  }
}
