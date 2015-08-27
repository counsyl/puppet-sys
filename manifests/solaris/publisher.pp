define sys::solaris::publisher(
  $uri,
  $ensure    = 'present',
  $preferred = false,
  $origin    = true,
  $nonsticky = false,
  $sticky    = false,
) {

  case $ensure {
    'present': {
      # Constructing options for the `pkg set-publisher` command.
      if $preferred {
        $preferred_opt = ' -P '
      } else {
        $preferred_opt = ''
      }

      if $origin {
        $origin_opt = ' -O '
      } else {
        $origin_opt = ''
      }

      if $nonsticky {
        $sticky_opt = '--non-sticky '
      } elsif $sticky {
        $sticky_opt = '--sticky '
      } else {
        $sticky_opt = ''
      }

      $pkg_opts = "${sticky_opt}${preferred_opt}${origin_opt}${uri}"

      exec { "pkg set-publisher ${name}":
        command => "pkg set-publisher ${pkg_opts} ${name}",
        path    => ['/bin', '/usr/bin'],
        unless  => "pkg publisher ${name} | grep 'Origin URI' | grep '${uri}'",
      }

      if $require {
        Exec["pkg set-publisher ${name}"]{
          require +> $require,
        }
      }

      if $before {
        Exec["pkg set-publisher ${name}"]{
          before +> $before,
        }
      }

    }
    'absent': {
      exec { "pkg unset-publisher ${name}":
        command => "pkg unset-publisher ${name}",
        path    => ['/bin', '/usr/bin'],
        onlyif  => "pkg publisher ${name} | grep 'Origin URI' | grep '${uri}'",
      }

      if $require {
        Exec["pkg unset-publisher ${name}"]{
          require +> $require,
        }
      }

      if $before {
        Exec["pkg unset-publisher ${name}"]{
          before +> $before,
        }
      }

    }
    default: {
      fail("Incorrect ensure value of '${ensure}'.\n")
    }
  }
}
