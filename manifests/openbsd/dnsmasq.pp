# == Class: sys::openbsd::dnsmasq
#
# Installs a simple DNS server/forwarder and DHCP service from the
# given network parameter hash.
#
class sys::openbsd::dnsmasq(
  $networks,
  $config        = '/etc/dnsmasq.conf',
  $cache_size    = '750',
  $domain        = "${::domain}",
  $expand_hosts  = true,
  $forwarders    = ['8.8.8.8', '8.8.4.4'],
  $default_lease = '24h',
  $rc_local      = '/etc/rc.conf.local',
  $rc_settings   = {
    'name'    => 'pkg_scripts',
    'value'   => 'dnsmasq',
    'comment' => 'Start third-party package scripts, like dnsmasq.',
  },
  $template      = 'sys/openbsd/dnsmasq.conf.erb',
  $extra         = undef,
) {
  include sys::openbsd::pkg

  package { 'dnsmasq':
    ensure => installed,
    source => $sys::openbsd::pkg::source,
  }

  file { $config:
    ensure  => file,
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template($template),
    require => Package['dnsmasq'],
  }

  if $rc_local {
    sys::openbsd::rc { $rc_local:
      settings => [$rc_settings],
      require  => File[$config],
    }
  }

  service { 'dnsmasq':
    ensure    => 'running',
    provider  => 'base',
    start     => '/usr/local/sbin/dnsmasq',
    subscribe => File[$config],
    require   => [Package['dnsmasq'], File[$config]],
  }
}
