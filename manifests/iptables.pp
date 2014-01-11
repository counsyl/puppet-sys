# == Class: sys::iptables
#
# This class creates a basic firewall for Linux systems using iptables.
# The `firewall` module from Puppet Labs is required for use:
#
#   https://github.com/puppetlabs/puppetlabs-firewall
#
# By default, this class enables all traffic access to the linkback interface,
# and only allows external traffic for SSH and ICMP ping.
#
# === Parameters
#
# [*ssh_port*]
#  The port that SSH will listen on, defaults to 22 or set to false to
#  disable.
#
# [*ping*]
#  Allow ICMP ping through the firewall?  Defaults to true.
#
# [*lo*]
#  Accept all packets on the linkback (lo) interface?  Defaults to true.
#
# [*iniface*]
#  Interface to apply iptables to, default is undefined.
#
class sys::iptables(
  $ssh_port = '22',
  $ping     = true,
  $lo       = true,
  $iniface  = undef,
  $purge    = true,
){
  if ! defined('firewall') {
    fail("sys::iptables requires puppetlabs-firewall module\n")
  }

  # Clears out any existing iptables rules, ensuring that only those
  # from Puppet are used.
  resources { 'firewall':
    purge => $purge,
  }

  # These defaults will ensure that the pre and post classes are run
  # in the correct order, to prevent being locked out.
  Firewall {
    before  => Class['sys::iptables::post'],
    require => Class['sys::iptables::pre'],
  }

  # Now declare the pre and post iptables dependencies.
  class { 'sys::iptables::pre':
    ssh_port => $ssh_port,
    ping     => $ping,
    lo       => $lo,
    iniface  => $iniface,
  }

  class { 'sys::iptables::post':
    iniface => $iniface,
  }

  # Declare the firewall resource -- this will autorequire the
  # `iptables` / `iptables-persistent` packages and install them.
  class { 'firewall': }
}
