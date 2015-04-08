# == Define: sys::openbsd::hosts
#
# Creates a hosts file at the path of its name based on the contents of the
# networks hash parameter.
#
# === Parameters
#
# [*networks*]
#  A hash indicating the hosts to place in the hosts file.  Each key corresponds
#  to a different network (e.g., a different IP space) though the value of the
#  key isn't important.  Each value should be a hash with a 'hosts' key, that
#  maps hostnames to IP addresses (and aliases) for that host.  Consult the
#  example below for more details.
#
# [*owner*]
#  The owner of the hosts file, defaults to 'root'.
#
# [*group*]
#  The group of the hosts file, defaults to 'wheel'.
#
# [*mode*]
#  The mode of the hosts file, defaults to '0644'.
#
# [*template*]
#  The template used to generate the hosts file, defaults to:
#  'sys/openbsd/hosts.erb'.
#
# === Example
#
# The following invocation:
#
#   sys::openbsd::hosts { '/etc/hosts':
#     networks => {
#       'client => {
#         'comment' => 'Client Network',
#         'hosts' => {
#           'workstation' => {
#             'ip' => '172.16.0.10',
#         }
#       },
#       'server' => {
#         'comment' => 'Server Network',
#         'hosts' => {
#           'db' => {
#             'ip' => '192.168.0.100',
#              'aliases' => ['db-01', 'db-us'],
#           }
#           'web' => {
#             'ip' => '192.168.0.80',
#             'aliases' => 'www'
#           }
#         }
#       }
#     }
#
# Creates a file at /etc/hosts with the following contents:
#
#   # Client Network
#   172.16.0.10     workstation
#   # Server Network
#   192.168.0.80    db db-01 db-us
#   192.168.0.100   web www
#
define sys::openbsd::hosts(
  $networks,
  $owner    = 'root',
  $group    = 'wheel',
  $mode     = '0644',
  $template = 'sys/openbsd/hosts.erb',
){
  validate_hash($networks)

  file { $title:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template($template),
  }
}
