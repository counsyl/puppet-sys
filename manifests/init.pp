# == Class: sys
#
# The sys module is a placeholder for common platform-dependent constants,
# including:
#
#  * $root_home:    The root user's home directory.
#  * $root_group:   The default group used for root's files.
#  * $binary_group: The default group used for system binaries.
#  * $nobody_group: The group for the 'nobody' user.
#
class sys {
  # Settings for the root and binary groups.
  case $::osfamily {
    darwin: {
      $binary_group = 'wheel'
      $root_group   = 'wheel'
    }
    solaris: {
      $binary_group = 'bin'
      $root_group   = 'bin'
    }
    openbsd: {
      $binary_group = 'bin'
      $root_group   = 'wheel'
    }
    windows: {
      $binary_group = 'SYSTEM'
      $root_group = 'Administrators'
    }
    default: {
      $binary_group = 'root'
      $root_group   = 'root'
    }
  }

  # The root home directory is different on OS X.
  case $::osfamily {
    darwin: {
      $root_home = '/var/root'
    }
    default: {
      $root_home = '/root'
    }
  }

  # If we're on Debian-based systems, they use 'nogroup' instead of 'nobody'.
  case $::osfamily {
    debian: {
      $nobody_group = 'nogroup'
    }
    default: {
      $nobody_group = 'nobody'
    }
  }
}
