# == Class: sys::ubnutu::network
#
# Class for creating the Ubuntu network configuration file.
#
# === Parameters
#
# [*interfaces*]
#  A hash of mapping interfaces to their configuration.  In other words,
#  each key is a networking device to configure (e.g., 'eth0') and it's
#  value is another hash describing it's configuration.
#
# [*defaults*]
#  A hash containing default network configuration information.
#
# === Examples
#
# Dynamically get network information for eth0:
#
#    class sys::ubuntu::network {
#      interfaces => {
#        'eth0' => {
#          'method' => 'dhcp',
#        }
#      }
#    }
#
# Have eth0 configured with DHCP and a static IP for eth1:
#
#    class sys::ubuntu::network {
#      interfaces => {
#        'eth0' => {
#          'method'  => 'dhcp',
#        },
#        'eth1' => {
#          'method'  => 'static',
#          'address' => '192.168.1.100',
#          'gateway' => '192.168.1.1',
#        },
#      }
#    }
#
class sys::ubuntu::network(
  $interfaces,
  $defaults        = {
    'family'  => 'inet',
    'lo'      => { 'family' => 'inet', 'method' => 'loopback' },
    'method'  => 'dhcp',
    'netmask' => '255.255.255.0',
  },
  $interfaces_file = '/etc/network/interfaces',
  $template        = 'sys/ubuntu/interfaces.erb'
){
  file { $interfaces_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
  }
}
