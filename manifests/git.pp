# == Class: sys::git
#
# Installs git, the distributed version control system.  If using on
# Windows, requires the `counsyl-windows` module.
#
# === Parameters
#
# [*ensure*]
#  The ensure value for the git package resources, defaults to 'installed'.
#
# [*package*]
#  The name of the git package to install, default is platform-dependent.
#
# [*provider*]
#  The provider for the package resource, default is platform-dependent.
#
# [*source*]
#  The source for the package resource, default is platform-dependent.
#
# [*install_options*]
#  The install options for the package resource, only defined on windows.
#
# [*base_url*]
#  Windows-only option, the base url to download the git installer, must
#  end in a slash.
#
# [*win_path*]
#  Windows-only option, if set this directory is added to the Windows %Path%.
#
class sys::git (
  $ensure          = 'installed',
  $package         = $sys::git::params::package,
  $provider        = $sys::git::params::provider,
  $source          = $sys::git::params::source,
  $install_options = $sys::git::params::install_options,
  $base_url        = $sys::git::params::base_url,
  $win_path        = $sys::git::params::win_path,
) inherits sys::git::params {
  # Extra gymnastics necessary if on windows.
  if $::osfamily == 'windows' {
    # If a source is passed in, use it -- this can be a HTTP URL or UNC.
    if $source {
      $source_uri = $source
    } else {
      $source_uri = "${base_url}${sys::git::params::basename}"
    }

    # If a non-UNC URL is used, download the Git setup with sys::fetch.
    if $source_uri !~ /^[\\]+/ {
      include windows
      $git_source = "${windows::installers}\\${sys::git::params::basename}"

      sys::fetch { 'download-git':
        destination => $git_source,
        source      => $source_uri,
        before      => Package[$package],
      }
    } else {
      $git_source = $source_uri
    }

    # If `$win_path` is set, ensure that Git is a component of the %PATH%.
    if $win_path {
      windows::path { 'git-path':
        directory => $win_path,
        require   => Package[$package],
      }

      if $::architecture == 'x64' {
        # Git now has native 64-bit support, remove 32-path.
        windows::path { 'git-path-legacy':
          ensure    => absent,
          directory => 'C:\Program Files (x86)\Git\cmd',
        }
      }
    }
  } else {
    $git_source = $source
  }

  # Install the package for git.
  package { $package:
    ensure          => $ensure,
    alias           => 'git',
    provider        => $provider,
    source          => $git_source,
    install_options => $install_options,
  }

  # Must have the git installed prior to using `vcsrepo` with it.
  if defined('vcsrepo') {
    Package[$package] -> Vcsrepo<| provider == git |>
  }
}
