# This class installs the Bash shell.
class sys::bash (
  $package  = $bash::params::package,
  $source   = $bash::params::source,
  $provider = $bash::params::provider,
  $extras   = $bash::params::extras
) inherits sys::bash::params {
  package { $package:
    ensure   => installed,
    source   => $source,
    provider => $provider,
  }
  if $extras {
    package { $extras:
      ensure   => installed,
      source   => $source,
      provider => $provider,
    }
  }
}
