# == Class: sys::wget
#
# Installs the wget, the url retrieval utility.
#
class sys::wget (
  $ensure      = 'installed',
  $package     = $sys::wget::params::package,
  $source      = $sys::wget::params::source,
  $provider    = $sys::wget::params::provider,
  $path        = $sys::wget::params::path,
  $ps_template = $sys::wget::params::ps_template,
) inherits sys::wget::params {
  if $::osfamily == 'windows' {
    include sys
    # Place a PowerShell script called `wget.ps1` in Windows %Path%.
    # Note: a template is used here because files served from puppet
    #  modules may be on file shares that Puppet can't introspect
    #  permissions on.
    file { $path:
      ensure => file,
      owner   => $sys::binary_group,
      group   => $sys::root_group,
      mode    => '0755',
      content => template($ps_template),
    }
  } else {
    package { $package:
      ensure   => $ensure,
      alias    => 'wget',
      provider => $provider,
      source   => $source,
    }
  }
}
