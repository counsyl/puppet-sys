# The following definition can be used to ensure that a
# line is in a file on a Solaris system.
define sys::solaris::line($file, $line, $ensure = 'present') {
  case $ensure {
    present: {
      exec { "echo '${line}' >> '${file}'":
        path    => ["/bin",],
        unless  => "grep '${line}' '${file}'",
      }
    }
    absent: {
      exec { "perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
        path   => ["/bin", "/usr/bin"], 
        onlyif => "grep '${line}' '${file}'",
      }
    }
    default: {
      fail( "Invalid ensure value ${ensure}.\n" )
    }
  }
}
