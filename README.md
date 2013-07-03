sys
===

This module contains classes, defined types, and parameters to assist system administrators and Puppet module authors.  This includes Puppet classes for:

* Installing common system utilities, shells, and terminal managers:
 * `sys::bash`
 * `sys::gcc`
 * `sys::git`
 * `sys::perl`
 * `sys::rsync`
 * `sys::screen`
 * `sys::tmux`
 * `sys::wget`
 * `sys::unzip`
 * `sys::zsh`

* OS-specific utilities and parameters for Ubuntu, RedHat, OpenBSD, and Solaris platforms:
 * `sys::ubuntu`
 * `sys::redhat`
 * `sys::openbsd`
 * `sys::solaris`

* `sys::ssh`: SSH configuration and hardening

* `sys::iptables`: Sets up Linux firewwall rules using [puppetlabs-firewall](http://forge.puppetlabs.com/puppetlabs/firewall) (required)

* `sys::inifile`: provides for [INI File](http://en.wikipedia.org/wiki/INI_file) creation

License
-------

Apache License, Version 2.0

Contact
-------

Justin Bronn <justin@counsyl.com>

Support
-------

Please log tickets and issues at https://github.counsyl.com/dev/puppet-sys
