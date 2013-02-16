# == Define: sys::apt::sources
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
# 'sys/apt/sources.list.erb'.
#
# === Examples
#
#   sys::apt::sources { '/etc/apt/sources.list':
#     repositories => [
#       { uri          => 'http://us.archive.ubuntu.com/ubuntu/',
#         distribution => 'precise',
#         components   => ['main', 'restricted'],
#       }
#     ],
#     source       => false,
#   }
#
define sys::apt::sources(
  $repositories,
  $source   = true,
  $template = 'sys/apt/sources.list.erb'
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
}
