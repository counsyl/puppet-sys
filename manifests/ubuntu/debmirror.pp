# == Class: sys::ubuntu::debmirror
#
# Configures an Ubuntu apt mirror using debmirror.
#
class sys::ubuntu::debmirror(
  $user           = 'debmirror',
  $uid            = '1001',
  $group          = $apache::params::group,
  $gid            = $apache::params::gid,
  $shell          = '/bin/sh',
  $arch           = ['amd64'],
  $host           = 'mirror.anl.gov',
  $package        = 'debmirror',
  $protocol       = 'rsync',
  $section        = ['main', 'restricted', 'universe', 'multiverse'],
  $source         = false,
  $release        = ["${::lsbdistcodename}",
                     "${::lsbdistcodename}-security",
                     "${::lsbdistcodename}-updates"],
  $root           = 'ubuntu',
  $rsync_options  = undef,
  $ubuntu_root    = "${apache::params::document_root}/ubuntu",
  $debmirror_site = "${apache::params::sites_available}/debmirror",
  $mirror_script  = '/usr/local/bin/mirror.sh',
  $ubuntu_keyring = '/usr/share/keyrings/ubuntu-archive-keyring.gpg',
) inherits apache::params {
  include apache
  include sys::rsync

  if $::operatingsystem != 'Ubuntu' {
    fail('Only supported on Ubuntu platforms.\n')
  }

  package { $package:
    ensure => installed,
  }

  $home = "/home/${user}"
  user { $user:
    ensure  => present,
    uid     => $uid,
    gid     => $gid,
    home    => $home,
    shell   => $shell,
    require => Class['apache::install'],
  }

  file { $home:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0600',
  }

  file { $ubuntu_root:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    require => Class['apache::install'],
  }

  file { $debmirror_site:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('sys/ubuntu/debmirror/debmirror.conf.erb'),
    notify  => Service['apache'],
    require => File[$ubuntu_root],
  }

  apache::site { 'default':
    ensure => disabled,
  }

  apache::site { 'debmirror':
    ensure  => enabled,
    require => File[$debmirror_site],
  }

  $debmirror_keyring = "${home}/.gnupg/trustedkeys.gpg"
  exec { 'build-keyring':
    command  => "gpg --keyring ${ubuntu_keyring} --export | gpg --no-default-keyring --keyring trustedkeys.gpg --import",
    user     => $user,
    path     => ['/usr/bin', '/bin'],
    creates  => $debmirror_keyring,
    require  => [User[$user], File[$home]],
  }

  file { $mirror_script:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('sys/ubuntu/debmirror/mirror.sh.erb'),
    require => [Package[$package], File[$ubuntu_root], Exec['build-keyring']],
  }
}
