# == Define: sys::openbsd::hosts
#
# Creates a hosts file at the path of its name.
#
define sys::openbsd::hosts(
  $networks,
  $owner    = 'root',
  $group    = 'wheel',
  $mode     = '0644',
  $template = 'sys/openbsd/hosts.erb',
){
  file { $name:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template($template),
  }
}
