# This class provides a common way to force apt updates on Debian platforms.
# When you want to force updates to these systems, simply change the value
# of the `$last_update` parameter.
#
# == Parameters
# [*last_update*]
#  A string of text to use as the contents of the last_update file; when
#  this text is changed, it will trigger an `apt-get` to upgrade installed
#  packages.
# [*kernel_upgrade*]
#  Whether or not to upgrade the kernel packages, which has to be done
#  explicitly (does not happen with an `apt-get upgrade` command).
#  Defaults to false.
#
class sys::ubuntu::apt-update($last_update, $kernel_upgrade=false){
  if $::osfamily != 'Debian' {
    fail("This class only supported on Debian-based platforms.\n")
  }

  # This file is used for forcing an update of all packages on an Ubuntu
  # system, including the kernel.  Change the value of the `$last_update`
  # variable to cause an update on any Ubuntu system.
  file { "/etc/apt/last_update":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $last_update,
  }

  # Execute `apt-get` to update the package lists, upgrade the packages,
  # install any new kernel packages (which must be installed separately),
  # and finally auto remove any stale packages from disk.
  $opts = "-o DPkg::Options=\"--force-confold\""
  exec { "apt-upgrade":
    command     => "apt-get -y update && apt-get -y ${opts} upgrade && apt-get -y autoremove",
    path        => ['/sbin', '/usr/sbin', '/bin', '/usr/bin'],
    user        => 'root',
    subscribe   => File["/etc/apt/last_update"],
    refreshonly => true,
    logoutput   => 'on_failure',
  }

  if $kernel_upgrade {
    # When a kernel upgrade is issued, the command to install has to be explicit
    # and does not happen automatically with `apt-get upgrade`.
    exec { "kernel-upgrade":
      command     => "apt-get -y install linux-server linux-headers-server && apt-get -y autoremove",
      path        => ['/sbin', '/usr/sbin', '/bin', '/usr/bin'],
      user        => 'root',
      subscribe   => Exec["apt-upgrade"],
      refreshonly => true,
      logoutput   => 'on_failure',
    }
  }
}
