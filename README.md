sys
===

This module contains classes, defined types, and parameters to assist system administrators and Puppet module authors.  This includes Puppet classes for:

* Installing common system utilities, shells, and terminal managers:
 * `sys::bash`
 * `sys::curl`
 * `sys::gcc`
 * `sys::git`
 * `sys::htop`
 * `sys::perl`
 * `sys::rsync`
 * `sys::screen`
 * `sys::tcsh`
 * `sys::tmux`
 * `sys::wget`
 * `sys::unzip`
 * `sys::zsh`

* OS-specific utilities and parameters for Debian/Ubuntu, RedHat, OpenBSD, and Solaris platforms:
 * `sys::apt`
 * `sys::ubuntu`
 * `sys::redhat`
 * `sys::openbsd`
 * `sys::solaris`

* `sys::dkms`: Installs DKMS to support dynamic linux kernel drivers.

* `sys::fetch`: Defined type for fetching files from URLs using wget or cURL.

* `sys::luks`: Installs `cryptsetup` package for encrypted drive support on Linux, and create encrypted device mappings with the `sys::luks::device` defined type.

* `sys::nfs`: Installs NFS client libraries.

* `sys::parted`: Installs GNU Parted on Linux systems.

* `sys::ssh`: SSH configuration and hardening

* `sys::stat`: For performance monitoring utilities like `iostat`.

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

Please log tickets and issues at https://github.com/counsyl/puppet-sys
