# == Define: sys::screen::rc
#
# Creates a screen resource file for the given user name.
#
# === Parameters
#
# If a parameter is undefined (undef) it will not be included in the
# screen resource file.
#
# [*name*]
#  The username to create the resource file for.
#
# [*ensure*]
#  Ensure value for this resource, defaults to 'present'.
#
# [*group*]
#  The group to use for the resource file, defaults to undef.
#
# [*home*]
#  The home directory the resource file is placed in, default
#  is determined by username (e.g., '/root' for root, and '/home/${name}'
#  for others).
#
# [*extra*]
#  Any extra configuration text to include the resource file.
#  Defaults to undef.
#
# [*template*]
#  Advanced usage only.  The template to use when generating the screen
#  resource file, defaults to "sys/screen/${::osfamily}.erb".
#
define sys::screen::rc(
  $ensure   = 'present',
  $group    = undef,
  $home     = undef,
  $extra    = undef,
  $template = "sys/screen/${::osfamily}.erb",
) {
  include sys::screen

  case $ensure {
    'present': {
      $file_ensure = 'file'
    }
    'absent': {
      $file_ensure = $ensure
    }
    default: {
      fail("Invalid sys::screen::rc ensure value: ${ensure}\n")
    }
  }

  if $home {
    $homedir = $home
  } else {
    if $name == 'root' {
      include sys
      $homedir = $sys::root_home
    } else {
      $homedir = "/home/${name}"
    }
  }

  # The template for the screen resource file; uses the following
  # variables from this scope:
  # * $extra
  file { "${homedir}/.screenrc":
    ensure  => $file_ensure,
    owner   => $name,
    group   => $group,
    mode    => '0600',
    content => template($template),
    require => Class['sys::screen'],
  }
}
