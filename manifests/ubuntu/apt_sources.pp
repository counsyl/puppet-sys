# == Define: sys::ubuntu::apt_sources
#
# Sets up a `sources.list` file for apt repositories.
#
# === Parameters
#
# [*mirror*]
#  The mirror server to use, uses Ubuntu's default.
#
# [*name*]
#  The name of this resource is the path to the apt list file.
#
# [*backports*]
#  Whether or not to include backport repositories, defaults to false.
#
# [*partner*]
#  Whether or not to include partner repositories, defaults to false.
#
# [*files*]
#  Array of local file paths to add.
#
# [*template*]
#  Template to use to render the sources.list, defaults to
# 'ubuntu/sources.list.erb'.
#
define sys::ubuntu::apt_sources(
  $mirror='http://us.archive.ubuntu.com/ubuntu/',
  $backports=false, $partner=false, $files=false,
  $template='sys/ubuntu/sources.list.erb'
  ){
  # The name of the resource should be the path to the apt
  # sources list, e.g., '/etc/apt/sources.list'.
  file { $name:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
  }

  # Pass in `require` and `before` metaparameters if defined.
  if $require {
    File[$name] {
      require +> $require,
    }
  }

  if $before {
    File[$name] {
      before +> $before,
    }
  }

  # Update the repository when apt sources have changed.
  exec { 'apt-update':
    subscribe   => File[$name],
    refreshonly => true,
    path        => ['/bin', '/usr/bin'],
    command     => 'apt-get -y update',
  }
}
