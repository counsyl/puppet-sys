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
class sys::iptables {
  if ! defined('firewall') {
    fail("sys::iptables requires puppetlabs-firewall module\n")
  }

  # Clears out any existing iptables rules, ensuring that only those
  # from Puppet are used.
  resources { 'firewall':
    purge => true,
  }

  # These defaults will ensure that the pre and post classes are run
  # in the correct order, to prevent being locked out.
  Firewall {
    before  => Class['sys::iptables::post'],
    require => Class['sys::iptables::pre'],
  }

  # Now declare the pre and post iptables dependencies.
  class { ['sys::iptables::pre', 'sys::iptables::post']: }

  # Declare the firewall resource -- this will autorequire the
  # `iptables` / `iptables-persistent` packages and install them.
  class { 'firewall': }
}
