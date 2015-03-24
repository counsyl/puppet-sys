# == Define: sys::openbsd::rc
#
# This class creates a rc.conf file for an OpenBSD platform, using
# the given settings.
#
# == Parameters
#
# [*settings*]
#  This is an array of settings to use in the `rc.conf` file, and may be
#  specified as either a Hash or a string value.  If specified as a hash, then
#  it must contain "name" and "value" keys of the setting and its value and may
#  also contain an optional "comment" key that will place a comment to the
#  associated setting.  The value will be automatically quoted, however, no
#  quoting will occur if the setting value is not a hash.
#
# [*ensure*]
#  The ensure for the file resource of the same name of this resource, defaults
#  to 'file'.
#
# [*owner*]
#  The owner of the rc.conf file, defaults to 'root'.
#
# [*group*]
#  The group of the rc.conf file, defaults to 'wheel'.
#
# [*mode*]
#  The mode of the rc.conf file, defaults to '0644'.
#
# [*template*]
#  The template to use when generating the rc.conf file, defaults to
#  'openbsd/rc.conf.erb'.
#
# == Example
#
#  $dhcpd = {
#    'name'    => 'dhcpd_flags',
#    'value'   => 'em0 em1',
#    'comment' => 'Start DHCP daemon.',
#  }
#
#  $ntpd = {
#   'name'  => 'ntpd_flags',
#   'value' => '',
#  }
#
#  $spamd_black = 'spamd_black=NO'
#
#  sys:openbsd::rc { '/etc/rc.conf.local':
#     settings => [ $dhcpd, $ntpd, $spamd_black ],
#  }
#
define sys::openbsd::rc(
  $settings,
  $ensure    = 'file',
  $owner     = 'root',
  $group     = 'wheel',
  $mode      = '0644',
  $template  = 'sys/openbsd/rc.conf.erb',
) {
  file { $title:
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template($template),
  }
}
