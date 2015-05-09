# == Define: sys::luks::device
#
# Creates an encrypted LUKS device mapping.
#
# Warning: This will overwrite any existing data on the specified device.
#
# Warning: The secret key may still be cached by Puppet in the compiled catalog
#  (/var/lib/puppet/client_data/catalog/*.json)  To prevent this secret from
#  persisting on disk you will have still have delete this file via some
#  mechanism, e.g., through a cron task or configuring the Puppet agent to
#  run a `postrun_command`, see:
#
#  http://docs.puppetlabs.com/references/stable/configuration.html#postruncommand
#
# === Parameters
#
# [*device*]
#  The hardware device to back LUKS with -- any existing data will be
#  lost when formatted as a LUKS device!
#
# [*key*]
#  The encryption key for the LUKS device.
#
# [*base64*]
#  Set to true if the key is base64-encoded (necessary for encryption keys
#  with binary data); defaults to false.
#
# [*mapper*]
#  The name to use in `/dev/mapper` for the device, defaults to the name
#  to the name of the resource.
#
# [*temp*]
#  Path to temporary file to store the encryption key in, defaults to
#  "/dev/shm/${name}".
#
# === Example
#
# The following creates a LUKS device at '/dev/mapper/data', backed by
# the partition at '/dev/sdb1', encrypted with the key 's3kr1t':
#
#   sys::luks::device { 'data':
#     device => '/dev/sdb1',
#     key    => 's3kr1t',
#   }
#
define sys::luks::device(
  $device,
  $key,
  $base64 = false,
  $mapper = $name,
  $temp   = "/dev/shm/${name}"
) {
  # Ensure LUKS is available.
  include sys::luks

  # Setting up unique variable names for the resources.
  $devmapper = "/dev/mapper/${mapper}"
  $create_key = "create-key-${name}"
  $delete_key = "delete-key-${name}"
  $luks_format = "luks-format-${name}"
  $luks_open = "luks-open-${name}"

  # Temporary file to hold the key.  Actual key contents are put in placed
  # and removed via the $create_key and $delete_key exec resources.
  file { $temp:
    ensure => file,
    backup => false,
    owner  => 'root',
    group  => 'root',
    mode   => '0400',
    notify => Exec[$create_key],
  }

  # Put key contents into temporary file; decode if base64-encoded.
  if $base64 {
    $create_key_cmd = "/bin/echo -n '${key}' | /usr/bin/base64 -d > ${temp}"
  } else {
    $create_key_cmd = "/bin/echo -n '${key}' > ${temp}"
  }

  exec { $create_key:
    command => $create_key_cmd,
    user    => 'root',
    unless  => "/usr/bin/test -b ${devmapper}",
    notify  => Exec[$luks_open],
  }

  # Format as LUKS device if it isn't already.
  exec { $luks_format:
    command => "/bin/echo 'YES' | /sbin/cryptsetup luksFormat ${device} ${temp}",
    user    => 'root',
    unless  => "/sbin/cryptsetup isLuks ${device}",
    require => [Class['sys::luks'], Exec[$create_key]],
  }

  # Open the LUKS device.
  exec { $luks_open:
    command     => "/sbin/cryptsetup --key-file ${temp} luksOpen ${device} ${mapper}",
    user        => 'root',
    onlyif      => "/usr/bin/test ! -b ${devmapper}",
    creates     => $devmapper,
    refreshonly => true,
    subscribe   => Exec[$create_key],
    notify      => Exec[$delete_key],
    require     => Exec[$luks_format],
  }

  # Shredding probably not necessary on ramdisk file, but nevertheless
  # scramble the contents at those pages with `shred` -- also covers
  # the case when temp location is customized.
  $shred = "/usr/bin/shred --iterations 10 --random=/dev/urandom ${temp}"
  exec { $delete_key:
    command     => "${shred} && /bin/echo -n > ${temp}",
    user        => 'root',
    refreshonly => true,
  }
}
