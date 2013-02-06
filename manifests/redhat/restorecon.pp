# == Define: sys::redhat::restorecon
#
# Set SELinux extended attributes for the file of the same name as this
# resource.  This needs to be done, for example, on a user's `authorized_keys`
# file to enable SSH login with key-based authentication.
#
define sys::redhat::restorecon(){
  exec { "/sbin/restorecon ${name}":
    subscribe   => File[$name],
    refreshonly => true,
  }
}
