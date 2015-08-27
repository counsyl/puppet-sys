# == Define: sys::apt::key
#
# Creates a trusted GPG key for an apt repository.
#
# === Parameters
#
# [*name*]
#  Required.  This is either a Puppet file URL to a GPG public key
#  (in binary format), or a 8-16 digit keyserver id.
#
# [*ensure*]
#  The ensure value for this resource, defaults to 'present'.
#
# [*server*]
#  When a public key ID is used, retrieve from this keyserver.  Defaults
#  to 'keyserver.ubuntu.com'.
#
define sys::apt::key(
  $key    = $name,
  $ensure = 'present',
  $owner  = 'root',
  $group  = 'root',
  $mode   = '0644',
  $server = 'keyserver.ubuntu.com',
){
  # Commands for adding and removing keys.
  $key_add = "apt-key adv --keyserver '${server}' --recv-keys '${key}'"
  $key_del = "apt-key del ${key}"

  # Command for listing keys -- we use `adv` instead of `list` so that
  # we can pass `--with-colon` option to GPG and get the long version
  # of the public keys.
  $key_list = 'apt-key adv --with-colon --batch --list-keys'
  $key_exists = "${key_list} | grep '^pub:-:[0-9]\\+:[0-9]\\+:${key}'"

  # Setting up depending on the ensure value.
  case $ensure {
    'present': {
      $file_ensure = 'file'
      $command = $key_add
      $onlyif = undef
      $unless = $key_exists
    }
    'absent': {
      $file_ensure = 'absent'
      $command = $key_del
      $onlyif = $key_exists
      $unless = undef
    }
    default: {
      fail("Invalid sys::apt::key ensure value: ${ensure}\n")
    }
  }

  # Determine how the key was passed in with regular expressions.
  if $key =~ /^puppet:\/\/\/.+\.gpg$/ {
    include sys::apt
    $basename = inline_template('<%= File.basename(@key) %>')
    $apt_key = "${sys::apt::trusted_d}/${basename}"
    file { $apt_key:
      ensure => $file_ensure,
      owner  => $owner,
      group  => $group,
      mode   => $mode,
      source => $key,
    }
  } else {
    exec { "apt-key-${name}":
      command   => $command,
      path      => ['/bin', '/usr/bin'],
      onlyif    => $onlyif,
      unless    => $unless,
      logoutput => 'on_failure',
    }
  }
}
