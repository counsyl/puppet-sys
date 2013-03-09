# == Class: sys
#
# The sys module is a placeholder for common platform-dependent constants.
#
class sys {
  # Every OS has different groups it uses.  Generalized settings for:
  # * $root_group:   The default group used for root's files.
  # * $binary_group: The default group used for system binaries.
  case $::osfamily {
    solaris: {
      $binary_group = 'bin'
      $root_group   = 'bin'
    }
    openbsd: {
      $binary_group = 'bin'
      $root_group   = 'wheel'
    }
    default: {
      $binary_group = 'root'
      $root_group   = 'root'
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
