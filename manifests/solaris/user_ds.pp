# Creates a ZFS dataset for given user name.
#
# == Parameters
# [*home_pool*]
#  The ZPool where the home dataset is stored.  Defaults to 'rpool' (used by
#  default on Solaris 11 and OpenIndiana).
# [*home_root*]
#  The root directory for all home filesystems.  Should also be a ZFS dataset
#  on the `home_pool` as well.  Defaults to '/export/home'.
#
define sys::solaris::user_ds($ensure='present', $home_pool='rpool', $home_root='/export/home') {
  require sys::solaris

  # Make sure that ZFS dataset for the admin user exists,
  # for example, `rpool/export/home/admin`.
  $user = $name
  $user_dataset = "${home_pool}${home_root}/${user}"
  zfs { $user_dataset:
    ensure => $ensure,
    before => User[$user],
  }

  # Ensure a line is in `/etc/auto_home` for our admin user.
  # This makes it so `/home/$user` actually exists -- ain't
  # Solaris great?
  sys::solaris::line { "autohome_${user}":
    file    => '/etc/auto_home',
    line    => "${user} localhost:${home_root}/&",
    ensure  => $ensure,
    before  => User[$user],
    require => Zfs[$user_dataset],
  }
}
