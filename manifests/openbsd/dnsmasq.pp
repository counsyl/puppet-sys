# == Class: sys::openbsd::dnsmasq
#
# Installs a simple DNS server/forwarder and DHCP services from the given
# network parameter hash.  In particular, this class will populate
# /etc/hosts and generate /etc/dnsmasq.conf dynamically from the given
# host information in the networks parameter (described below).
#
# === Parameters
#
# Most parameters correspond directly to DNSmasq configuration options.
#
# [*networks*]
#  A hash containing the information for the networks you want to serve.  Each
#  key corresponds to a network, which is another hash with the information
#  necessary to run DNS and DHCP services for that network.  The hostnames and
#  IP addresses are kept in a 'hosts' subkey, with the DHCP ranges kept in a
#  'ranges' subkey.  The hosts hash maps hostnames to IP addresses (contained in
#  a 'ip' key) and MAC addresses (optional, contained in a 'mac' key).
#
# === Example
#
# The following would create add two hosts, ldap and www, to /etc/hosts
# and configure dnsmasq.conf to assign the IP to the MAC address for
# ldap and for any DHCP client identifying as www (since no MAC was
# specified).  The range from 192.168.0.50-100 is used for dynamic
# leases:
#
#   class { 'sys::openbsd::dnsmasq':
#     networks => {
#       'servers' => {
#         'hosts' => {
#           'ldap' => {
#             'ip'  => '192.168.0.10',
#             'mac' => '00:80:de:ad:be:ef',
#           },
#           'www' => {
#             'ip'  => '192.168.0.80',
#           }
#         },
#         'ranges' => [ [ '192.168.0.50', '192.168.0.100' ] ],
#       }
#     },
#     domain     => 'servers.counsyl.com',
#     forwarders => [ '192.168.10.1', '192.168.10.2' ],
#   }
#
class sys::openbsd::dnsmasq(
  $networks,
  $authoritative      = false,
  $config             = '/etc/dnsmasq.conf',
  $cache_size         = '750',
  $default_lease      = '24h',
  $domain             = $::domain,
  $expand_hosts       = true,
  $etc_hosts          = '/etc/hosts',
  $except_interfaces  = [],
  $forwarders         = ['8.8.8.8', '8.8.4.4'],
  $interfaces         = [],
  $listen_addresses   = [],
  $no_dhcp_interfaces = [],
  $package            = 'dnsmasq',
  $service            = 'dnsmasq',
  $service_enable     = true,
  $service_ensure     = 'running',
  $template           = 'sys/openbsd/dnsmasq.conf.erb',
  $extra              = false,
) {
  include sys::openbsd::pkg

  validate_hash($networks)
  validate_array(
    $except_interfaces, $forwarders,
    $interfaces, $listen_addresses,
    $no_dhcp_interfaces
  )

  package { $package:
    ensure => installed,
  }

  sys::openbsd::hosts { $etc_hosts:
    networks => $networks,
  }

  file { $config:
    ensure  => file,
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template($template),
    require => [Package[$package], File[$etc_hosts]],
  }

  if $service {
    service { $service:
      ensure    => $service_ensure,
      enable    => $service_enable,
      subscribe => File[$config, $etc_hosts],
      require   => Package[$package],
    }
  }
}
