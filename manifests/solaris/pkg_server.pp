# == Class: sys::solaris::pkg_server
#
# Creates a `pkg/server` instance for the given parameters.
#
# === Parameters
#
# [*inst_root*]
#  Where the instance should find it's repository data.
#
# [*port*]
#  The port this instance should listen on.
#
# [*proxy_base*]
#  The proxy base URL for this repository.
#
# [*address*]
#  The IP address for the pkg/server instance to listen on,
#  defaults to 127.0.0.1.
#
# [*fmri*]
#  The base FMRI of the pkg service, defaults to 'pkg/server'.
#
define sys::solaris::pkg_server(
  $inst_root,
  $port,
  $proxy_base,
  $address     = '127.0.0.1',
  $fmri        = 'pkg/server'
){
  $service = "pkg/server:${name}"
  $config = "/root/pkg5-${name}"

  file { $config:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('sys/solaris/pkg_server.erb'),
  }

  Exec {
    path => '/usr/sbin'
  }

  exec { "create-${service}":
    command     => "svccfg -s ${fmri} -f ${config}",
    subscribe   => File[$config],
    refreshonly => true,
  }

  exec { "refresh-${service}":
    command     => "svcadm refresh ${service} && svcadm enable ${service}",
    subscribe   => Exec["create-${service}"],
    refreshonly => true,
  }

  service { $service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Exec["refresh-${service}"],
  }
}
