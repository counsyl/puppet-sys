# == Class: sys::iptables::pre
#
# Global firewall defaults applied after custom rules. 
#
class sys::iptables::post {
  firewall { '999 drop everything else':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
