# == Define: sys::fetch
#
# Fetch a file using a download program.
#
# Note: Windows support requires the joshcopper-powershell module.
#
# === Parameters
#
# [*destination*]
#  Required, the local filesystem location to retrieve the file to.
#
# [*source*]
#  The source URL for the download, defaults to the $name of the resource.
#
# [*redownload*]
#  Whether or not to check to see if the retrieved file has a size (rather than
#  just seeing if it exists).  Defaults to true.
#
# [*cert_check*]
#  Whether to check HTTPS certificates for validity, defaults to false.
#
# [*logoutput*]
#  The `logoutput` value for the fetching `exec` resource, defaults to 'on_failure'.
#
# [*path*]
#  The `path` value for the fetching `exec` resource, defaults to:
#  ['/bin', '/usr/bin', '/usr/local/bin'].
#
# [*timeout*]
#  The `timeout` value for the fetching `exec` resource, defaults to '0' (which
#  implies no time limit on download).
#
# [*user*]
#  The `user` value for the fetching `exec` resource, defaults is undefined.
#
define sys::fetch(
  $destination,
  $source       = $name,
  $redownload   = true,
  $cert_check   = false,
  $logoutput    = 'on_failure',
  $path         = ['/bin', '/usr/bin', '/usr/local/bin'],
  $timeout      = '0',
  $user         = undef,
) {

  if ($redownload and $::osfamily != 'windows') {
    $unless  = "test -s ${destination}"
    $creates = undef
  } else {
    $unless  = undef
    $creates = $destination
  }

  case $::osfamily {
    darwin: {
      # Use cURL on OS X.
      if $cert_check {
        $cert_check_opt = ''
      } else {
        $cert_check_opt = '--insecure'
      }
      $output_opt = "--output '${destination}'"
      $dl_cmd = '/usr/bin/curl --silent --location'
      $provider = undef
    }
    windows: {
      # Use PowerShell provider (via joshcooper's powershell module).
      $provider = 'powershell'
    }
    default: {
      # Use wget everywhere else.
      include sys::wget
      if $cert_check {
        $cert_check_opt = ''
      } else {
        $cert_check_opt = '--no-check-certificate'
      }
      $output_opt = "--output-document='${destination}'"
      $dl_cmd = "${sys::wget::path} --quiet"
      $fetch_require = Class['sys::wget']
      $provider = undef
    }
  }

  if $::osfamily == 'windows' {
    $command = "(New-Object Net.WebClient).DownloadFile('${source}', '${destination}')"
  } else {
    # Constructing download options string using stdlib's `join` function.
    $dl_opts = join([$cert_check_opt, $output_opt, "'${source}'"], ' ')
    $command = "${dl_cmd} ${dl_opts}"
  }

  exec { "fetch-${name}":
    command   => $command,
    user      => $user,
    timeout   => $timeout,
    logoutput => $logoutput,
    path      => $path,
    unless    => $unless,
    creates   => $creates,
    provider  => $provider,
    require   => $fetch_require,
  }
}
