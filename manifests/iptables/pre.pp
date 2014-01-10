# == Class: sys::iptables::pre
#
# Global firewall defaults applied before custom rules.
#
# Private class, do not use directly.
#
class sys::iptables::pre(
  $ssh_port,
  $ping,
  $lo,
  $iniface,
){
  Firewall {
    require => undef,
  }

  firewall { '000 allow packets with valid state':
    action  => 'accept',
    proto   => 'all',
    state   => [ 'RELATED', 'ESTABLISHED' ],
    iniface => $iniface,
  }

  if $ping {
    firewall { '001 allow icmp ping':
      action  => 'accept',
      proto   => 'icmp',
      icmp    => 'echo-request',
      iniface => $iniface,
    }
  }

  if $lo {
    firewall { '002 allow all to lo interface':
      action  => 'accept',
      proto   => 'all',
      iniface => 'lo',
    }
  }

  if $ssh_port {
    firewall { '010 allow ssh':
      action  => 'accept',
      proto   => 'tcp',
      dport   => $ssh_port,
      iniface => $iniface,
    }
  }
}
