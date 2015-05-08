# Creates an identity mapping between the given windows name and the
# the solaris user (specified by the name of the define).
#
# == Parameters
#
# [*winname*]
#  The windows name to map the unix account to.
#
# [*group*]
#  Indicates that the windows name is a group (and will be
#  mapped to a unix group with same name as this resource).
#
# [*unixname*]
#  Defaults to the same as `$name`, option used for overridding the
#  UNIX mapping name when it should be different from $name.
#
define sys::solaris::idmap(
  $winname,
  $group    = false,
  $unixname = undef,
) {
  include sys::solaris::cifs

  # If the unix name parameter is provided, then use that as the
  # name of the UNIX user/group rather than $name.
  if $unixname {
    $unix_name = $unixname
  } else {
    $unix_name = $name
  }

  # The same command that is used to add the mapping is used when
  # grepping the mapping from `idmap list`; the two spaces after
  # 'add' are significant.
  if $group {
    $idmap = "add  wingroup:${winname} unixgroup:${unix_name}"
    $exec_name = "idmap-group-${unix_name}"
  } else {
    $idmap = "add  winname:${winname} unixuser:${unix_name}"
    $exec_name = "idmap-${unix_name}"
  }

  # Finally, setting up the exec resource that will create the identity
  # mapping between the windows name and the unix name; notify the idmap
  # and smb/server services when this is done.
  exec { $exec_name:
    path    => [ '/usr/sbin', '/bin', '/usr/bin'],
    command => "idmap ${idmap}",
    unless  => "idmap list | tr '\t' ' ' | grep '^${idmap}$'",
    notify  => [ Service['system/idmap'], Service['network/smb/server'] ],
  }
}
