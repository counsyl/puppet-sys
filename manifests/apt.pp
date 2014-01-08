# == Class: sys::apt
#
# Base class for module, provides platform dependent parameters for the
# APT packaging system.  Advanced parameters may be used to customize
# site-wide settings (like location of apt configuration files and
# binaries).
#
# === Parameters
#
# [*root*]
#  The root configuration folder for apt.  Defaults to '/etc/apt'
#
# [*provider*]
#  The path to the apt-get binary.  Defaults to '/usr/bin/apt-get'.
#
# [*dpkg_opts*]
#  Underlying options to pass to `dpkg` when performing upgrades with
#  apt.  Defaults to '-o DPkg::Options="--force-confold"'.
#
# [*cache*]
#  The path to the apt cache, defaults to '/var/cache/apt'.
#
class sys::apt(
  $root      = '/etc/apt',
  $provider  = '/usr/bin/apt-get',
  $dpkg_opts = '-o DPkg::Options="--force-confold"',
  $cache     = '/var/cache/apt',
){
  if $::osfamily != 'Debian' {
    fail("This class only supported on Debian-based platforms.\n")
  }

  # Directory locations.
  $conf_d        = "${root}/apt.conf.d"
  $sources_d     = "${root}/sources.list.d"
  $preferences_d = "${root}/preferences.d"

  # Trusted GPG keystore locations.
  $trusted_gpg   = "${root}/trusted.gpg"
  $trusted_d     = "${root}/trusted.gpg.d"

  # apt-get command variable shortcuts.
  $autoremove    = "${provider} -y autoremove"
  $install       = "${provider} -y install"
  $update        = "${provider} -y update"
  $upgrade       = "${provider} -y ${dpkg_opts} upgrade"
}
