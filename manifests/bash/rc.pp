# Create a bash resource file for the given user name.
define sys::bash::rc(
  $group      = undef,
  $editor     = undef,
  $extra      = undef,
  $path       = undef,
  $pythonpath = undef,
  $template   = "sys/bash/${::osfamily}.erb",
  ) {
  require sys::bash

  if $path != '' {
    $bashpath = $path
  } else {
    $bashpath = $sys::bash::path
  }

  # The template for the bash resource file; uses the following
  # variables from this scope:
  # * $bashpath
  # * $pythonpath
  # * $editor
  # * $extra
  if $name == 'root' {
    $home = '/root'
  } else {
    $home = "/home/${name}"
  }

  file { "${home}/.bashrc":
    ensure  => file,
    owner   => $name,
    group   => $group,
    mode    => '0600',
    content => template($template),
    require => Class['sys::bash'],
  }

  file { "${home}/.bash_profile":
    ensure  => file,
    owner   => $name,
    group   => $group,
    mode    => '0600',
    content => "test -r ~/.bashrc && source ~/.bashrc\n",
    require => File["${home}/.bashrc"],
  }

  if $::operatingsystem == Solaris {
    file { "${home}/.zfs_completion":
      ensure => file,
      mode   => '0600',
      owner  => $name,
      group  => $group,
      source => 'puppet:///modules/sys/bash/zfs_completion',
    }
  }
}
