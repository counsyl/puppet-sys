# == Class: sys::apt::update
#
# Specifies the command to update the APT package indices.
#
class sys::apt::update {
  include sys::apt
  exec { 'apt-update':
    command     => $sys::apt::update,
    logoutput   => 'on_failure',
    refreshonly => true,
  }
}
