class sys::solaris::files {
  # These are essential networking and other configuration
  # files necessary for a functioning solaris host.
  file { '/etc/auto_home':
    ensure => file,
    mode   => '0644',
    owner  => 'root',
    group  => 'bin',
  }

  file { '/etc/inet/hosts':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'sys',
    content => template('sys/solaris/hosts.erb'),
  }

  file { '/etc/hosts':
    ensure => link,
    target => './inet/hosts',
    owner  => 'root',
    group  => 'root',
  }
}
