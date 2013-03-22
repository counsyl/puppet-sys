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
#  [*ssh_port*]
#   The port that SSH will listen on.  Defaults to 22.
#
class sys::iptables(
  $ssh_port = '22',
) inherits sys::iptables::params {

  if $package {
    # The package name for debian systems.
    package { $package:
      ensure => installed,
      before => Exec['persist-firewall'],
    }

    # Ensure the `iptables-persistent` service is enabled; this isn't a
    # "real" service, as it just loads up the iptables rules from file
    # after a reboot.
    service { $service:
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => $hasstatus,
      status     => $status,
      require    => Package[$package],
    }
  }
    
  # This command persists the iptables to the rules file of the platform.
  exec { 'persist-firewall':
    command     => "/sbin/iptables-save > ${rules}",
    refreshonly => true,
    logoutput   => 'on_failure',
  }

  # On every firewall rule, ensure that we notify the persistence command
  # (so that the rules will be loaded on machine reboot).
  Firewall {
    notify => Exec['persist-firewall']
  }

  firewall { '000 allow packets with valid state':
    action => 'accept',
    state  => [ 'RELATED', 'ESTABLISHED' ],
  }

  firewall { '001 allow icmp ping':
    action => 'accept',
    proto  => 'icmp',
    icmp   => 'echo-request',
  }

  firewall { '002 allow all to lo interface':
    action  => 'accept',
    iniface => 'lo',
  }

  firewall { '010 allow ssh':
    action => 'accept',
    proto  => 'tcp',
    dport  => $ssh_port,
  }

  firewall { '999 drop everything else':
    action => 'drop',
  }

  resources { 'firewall':
    purge => true,
  }
}
