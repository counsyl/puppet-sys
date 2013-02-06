# This class enables the hotplug service on Solaris platforms, useful
# for storage platforms.
class sys::solaris::hotplug {
  service { 'system/hotplug:default':
    ensure => running,
  }
}
