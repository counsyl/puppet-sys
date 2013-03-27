# == Define: sys::git::config
#
# Ensures that the given git repository has a configuration setting
# of it's name set to the value.
#
# === Parameters
#
# [*value*]
#  Required: the value of the configuration setting specified by $name.
#
# [*repo*]
#  Required: the path to the git repository.
#
# [*user*]
#  The user to execute the git configuration commands as, defaults to 'root'.
#
# [*scope*]
#  The scope of the configuration value, may be global, local, or system.
#  Default is local.
#
# [*binary*]
#  Path to the git binary, defaults to '/usr/bin/git'.
#
define sys::git::config(
  $value,
  $repo,
  $user   = 'root',
  $scope  = 'local',
  $binary = '/usr/bin/git',
){
  if ! ($scope in ['global', 'local', 'system']) {
    fail("Invalid scope value.\n")
  }

  $git = "${binary} config --${scope}"
  $quoted = shellquote($value)
  $pattern = shellquote("^${value}$")
  $config_set = "${git} --get ${name} | grep ${pattern}"
  $config_add = "${git} --add ${name} ${quoted}"

  # Must have unique resource name.
  $exec_name = "${repo}-${scope}-${name}-${value}"
  exec { $exec_name:
    command => $config_add,
    cwd     => $repo,
    unless  => $config_set,
    user    => $user,
    require => Class['sys::git'],
  }
}
