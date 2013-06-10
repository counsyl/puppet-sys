# == Class: sys::iptables::pre
#
# Global firewall defaults applied before custom rules.
#
# === Parameters
#
#  [*ssh_port*]
#   The port that SSH will listen on, defaults to 22 or set to false to
#   disable.
#
#  [*ping*]
#   Allow ICMP ping through the firewall?  Defaults to true.
#
#  [*lo*]
#   Accept all packets on the linkback (lo) interface?  Defaults to true.
#
class sys::iptables::pre(
  $ssh_port = '22',
  $ping     = true,
  $lo       = true,
){
  Firewall {
    require => undef,
  }

  firewall { '000 allow packets with valid state':
    proto  => 'all',
    action => 'accept',
    state  => [ 'RELATED', 'ESTABLISHED' ],
  }

  if $ping {
    firewall { '001 allow icmp ping':
      action => 'accept',
      proto  => 'icmp',
      icmp   => 'echo-request',
    }
  }

  if $lo {
    firewall { '002 allow all to lo interface':
      action  => 'accept',
      iniface => 'lo',
    }
  }

  if $ssh_port {
    firewall { '010 allow ssh':
      action => 'accept',
      proto  => 'tcp',
      dport  => $ssh_port,
    }
  }
}
