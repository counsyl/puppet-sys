# This define is a convenience wrapper around `solaris::zfs::property` to turn
# ZFS deduplication on the dataset sharing the same name as the resource.
define sys::solaris::zfs::dedup(
  $value = 'on',
) {
  sys::solaris::zfs::property { "${name} dedup":
    property => 'dedup',
    value    => $value,
    dataset  => $name,
  }
}
