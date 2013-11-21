# == Class: sys::ubuntu::ipv6
#
# This class is used to control the state of IPv6 on the Ubuntu host
# by setting the appropriate values in '/etc/sysctl.conf'.
#
# By default, this disables IPv6 (it's enabled by default on Ubuntu).
#
# === Parameters
#
# [*ensure*]
#  Defaults to 'disabled'.
#
# [*sysctl*]
#  Path to the sysctl configuration file.  Defaults to '/etc/sysctl.conf'.
#
class sys::ubuntu::ipv6(
  $ensure = 'disabled',
  $sysctl = '/etc/sysctl.conf',
) {

  case $ensure {
    'enabled', 'installed': {
      $status = '0'
    }
    'disabled', 'absent', 'removed': {
      $status = '1'
    }
    default: {
      fail('Invalid ensure status for sys::ubuntu::ipv6.\n')
    }
  }

  # Use the `file_line` resource from puppetlabs-stdlib to set the appropriate
  # configuration values in /etc/sysctl.conf.
  file_line { 'ipv6_conf_all_disable':
    path  => $sysctl,
    match => 'net.ipv6.conf.all.disable_ipv6',
    line  => "net.ipv6.conf.all.disable_ipv6 = ${status}",
  }

  file_line { 'ipv6_conf_default_disable':
    path  => $sysctl,
    match => 'net.ipv6.conf.default.disable_ipv6',
    line  => "net.ipv6.conf.default.disable_ipv6 = ${status}",
  }

  file_line { 'ipv6_lo_disable':
    path  => $sysctl,
    match => 'net.ipv6.conf.lo.disable_ipv6',
    line  => "net.ipv6.conf.lo.disable_ipv6 = ${status}",
  }
}
