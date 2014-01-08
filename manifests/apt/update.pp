# == Class: sys::apt::update
#
# This class creates an `exec` resource, named "apt-update" that may be
# used to receive notifications prior to package installation.
#
class sys::apt::update(
  $exec_name   = 'apt-update',
  $logoutput   = 'on_failure',
  $refreshonly = true,
  $timeout     = undef,
) {
  include sys::apt
  exec { $exec_name:
    command     => $sys::apt::update,
    logoutput   => $logoutput,
    refreshonly => $refreshonly,
    timeout     => $timeout,
  }
}
