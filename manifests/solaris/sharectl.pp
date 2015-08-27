# This define provides a way to manipulate sharectl properties
# for the given protocol.
define sys::solaris::sharectl(
  $protocol,
  $value,
){
  exec { "sharectl-${name}":
    path    => [ '/usr/sbin', '/bin'],
    command => "sharectl set -p ${name}=${value} ${protocol}",
    unless  => "sharectl get -p ${name} ${protocol} | grep '^${name}=${value}$'",
  }
}
