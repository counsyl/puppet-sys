# This define sets a ZFS property to the given value on the dataset with the same
# name as the define.
define sys::solaris::zfs::property(
  $property,
  $value,
  $dataset = undef,
) {
  # The dataset keyword is used when you want to set multiple properties
  # on a single ZFS dataset ane need to use a unique resource name for
  # each one.
  if $dataset {
    $zfs_dataset = $dataset
  } else {
    $zfs_dataset = $name
  }

  # Commands for setting the ZFS property and checking whether it
  # is set to the proper value.
  $set_property = "zfs set ${property}=${value} ${zfs_dataset}"
  $property_set = "zfs get -H -o value ${property} ${zfs_dataset} | grep '^${value}$'"

  exec { $set_property:
    path    => [ '/sbin', '/usr/sbin', '/bin', '/usr/bin' ],
    unless  => $property_set,
    require => Zfs[$zfs_dataset],
  }
}
