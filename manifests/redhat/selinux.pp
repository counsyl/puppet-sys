# == Define: sys::redhat::selinux
#
# Sets the SELinux enforcement policy.
#
define sys::redhat::selinux(
  $config      = '/etc/selinux/config',
  $selinuxtype = 'targeted',
  $template    = 'sys/redhat/selinux-config.erb',
) {
  $allowed_enforce = ['enabled', 'disabled', 'permissive']
  $allowed_types = ['targeted', 'mls']
  if ($name in $allowed_enforce) and ($selinuxtype in $allowed_types) {
    # Set the SELinux configuration file with the given name and type,
    # so the setting will persist across reboots.
    file { $config:
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($template)
    }

    if $name == 'enabled' {
      $enforce = '1'
    } else {
      $enforce = '0'
    }

    # This makes SELinux setting take effect immediately.
    exec { 'selinux-enforce':
      command     => "/bin/echo ${enforce} > /etc/selinux/enforce",
      refreshonly => true,
      subscribe   => File['/etc/selinux/config'],
    }
  } else {
    fail('Invalid SELINUX or SELINUXTYPE configuration values.')
  }
}
