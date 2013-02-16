# == Class: sys::apt::update
#
# This class provides a common way to force apt updates on Debian platforms.
# When you want to force updates to these systems, simply change the value
# of the `$last_update` parameter.
#
# === Parameters
#
# [*last_update*]
#  A string of text to use as the contents of the last_update file; when
#  this text is changed, it will trigger an `apt-get` to upgrade installed
#  packages.
#
# [*last_update_file*]
#  File to use that holds the `last_update` content.  Defaults to:
#  '/etc/apt/last_update'.
#
# [*kernel_upgrade*]
#  Whether or not to upgrade the kernel packages, which has to be done
#  explicitly (does not happen with an `apt-get upgrade` command).
#  Defaults to false.
#
# [*kernel_packages*]
#  List of packages to upgrade when `kernel_upgrade` is set.  Defaults to:
#  ['linux-server', 'linux-headers-server'].
#
class sys::apt::upgrade(
  $last_update,
  $last_update_file = "${sys::apt::root}/last_update",
  $kernel_upgrade   = false,
  $kernel_packages  = ['linux-server', 'linux-headers-server'],
) inherits sys::apt {
  include sys::apt::update
  
  # This file is used for forcing an update of all packages on an Debian
  # system, including the kernel.  Change the value of the `$last_update`
  # variable to cause an update on any Debian system.
  file { $update_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${last_update}\n",
    notify  => Exec['apt-upgrade'],
  }

  # Execute `apt-get` to update the package lists, upgrade the packages,
  # install any new kernel packages (which must be installed separately),
  # and finally auto remove any stale packages from disk.
  exec { 'apt-upgrade':
    command     => "${sys::apt::update} && ${sys::apt::upgrade} && ${sys::apt::autoremove}",
    user        => 'root',
    refreshonly => true,
    logoutput   => 'on_failure',
  }

  if $kernel_upgrade {
    $kernel_pkgs = inline_template("<%= @kernel_packages.join(' ') %>")
    $kernel_install = "${sys::apt::install} ${kernel_pkgs}"

    # When a kernel upgrade is issued, the command to install has to be explicit
    # and does not happen automatically with `apt-get upgrade`.
    exec { 'kernel-upgrade':
      command     => "${kernel_install} && ${sys::apt::autoremove}",
      user        => 'root',
      refreshonly => true,
      logoutput   => 'on_failure',
      subscribe   => Exec['apt-upgrade'],
    }
  }
}
