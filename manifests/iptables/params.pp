# == Class: sys::iptables::params
#
# Linux platform-dependent variables for iptables.
#
class sys::iptables::params {
  case $::osfamily {
    debian: {
      if ($::operatingsystem == 'Ubuntu') and (versioncmp($::lsbmajdistrelease, '12') >= 0) {
        # Variables for the rules file, and name/path of the custom package.
        $rules = '/etc/iptables/rules.v4'

        # Of course, the service script behaves differently on 12.04
        # and doesn't support the `status` subcommand.  Thus, we have to set
        # a custom status command that returns 0 if the rules file exists.
        $hasstatus = false
        $status = "/usr/bin/test -f ${rules}"
      } else {
        # On older versions of Ubuntu, this is the path of the rules file
        # when `iptables-persistent` is installed non-interactively.
        $rules = '/etc/iptables/rules'
        $hasstatus = true
        $status = undef
      }

      $package = 'iptables-persistent'
      $service = 'iptables-persistent'
    }
    redhat: {
      $rules = '/etc/sysconfig/iptables'
    }
    default: {
      fail("Do not know how to persist iptables on ${::operatingsystem}.\n")
    }
  }
}
