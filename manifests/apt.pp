# == Class: sys::apt
#
# Platform dependent parameters for APT packaging system.
#
class sys::apt(
  $root      = '/etc/apt',
  $provider  = '/usr/bin/apt-get',
  $dpkg_opts = '-o DPkg::Options="--force-confold"',
){
  if $::osfamily != 'Debian' {
    fail("This class only supported on Debian-based platforms.\n")
  }

  # Directory locations.
  $conf_d        = "${root}/apt.conf.d"
  $sources_d     = "${root}/sources.list.d"
  $preferences_d = "${root}/preferences.d"

  # apt-get command variable shortcuts.
  $autoremove    = "${provider} -y autoremove"
  $install       = "${provider} -y install"
  $update        = "${provider} -y update"
  $upgrade       = "${provider} -y ${dpkg_opts} upgrade"
}
