# == Class: sys::ssh
#
# This class installs and configures SSH.
#
# == Parameters
#
# [*port*]
#  The port that the SSH daemon will listen on, defaults to 22.
#  May be specified multiple times as an array.
#
# [*listen_address*]
#  Specifies the address(es) to listen on, may be specifed as an array
#  or a string.  Default is undefined (listen on all interfaces).
#
# [*acceptenv*]
#  Array that specifies what environment variables sent by the client
#  will be copied into the client session's environment (on non-Solaris
#  systems).  Defaults to `[ 'LANG', 'LC_*' ]`.
#
# [*agent_forwarding*]
#  Whether or not to allow agent forwarding, defaults to false.
#
# [*authorized_keys_command*]
#  Specifies a program to be used to look up the user's public keys;
#  maps to the AuthorizedKeysCommand sshd_config variable (requires
#  OpenSSH 6.2+).
#
# [*authorized_keys_command_user*]
#  Specifies the user to run the `authorized_keys_command` (if specified).
#
# [*authorized_keys_file*]
#  A string, or an array of strings, used to specify the file(s) that can
#  be used for user authentication.
#
# [*authorized_principals_file*]
#  Specifies a file that lists principal names that are accepted for
#  certificate authentication; maps to the AuthorizedPrincipalsFile
#  sshd_config variable. Defaults to false.
#
# [*allowusers*]
#  An array of users allowed SSH access; maps to the AllowUsers
#  sshd_config variable.  Defaults to false.
#
# [*allowgroups*]
#  An array of groups allowed SSH access; maps to the AllowGroups
#  sshd_config variable.  Defaults to false.
#
# [*denyusers*]
#  An array of users denied SSH access; maps to the DenyUsers
#  sshd_config variable.  Defaults to false.
#
# [*denygroups*]
#  An array of groups denied SSH access; maps to the DenyGroups
#  sshd_config variable.  Defaults to false.
#
# [*challenge_response*]
#  Specifies whether challenge-response authentication is allowed,
#  defaults to true.
#
# [*ciphers*]
#  Specifies the ciphers allowed for protocol version 2, must be
#  given as an array.  Default is [].
#
# [*empty_passwords*]
#  Whether or not to allow empty passwords, defaults to false.
#
# [*host_key_algorithms*]
#  Specifies the host key algorithms that the server offers, defaults to [].
#
# [*kex_algorithms*]
#  Specifies the available KEX (Key Exchange) algorithms, must be
#  given as an array, defaults to [].
#
# [*login_grace_time*]
#  Time (in seconds) that the SSH daemon will disconnect if the
#  user has not successfully logged in.  Defaults to 120.
#
# [*log_level*]
#  The logging level of the SSH daemon, defaults to 'INFO'.
#
# [*macs*]
#  Specifies the available MAC (message authentication code) algorithms,
#  must be given as an array.  Default is [].
#
# [*root_login*]
#  Determines whether root logins are permitted, defaults to false.
#
# [*rsa_auth*]
#  Determines whether pure RSA authentication is allowed when SSH
#  protocol 1 is used, defaults to true.
#
# [*pubkey_auth*]
#  Specifies whether public key authentication is allowed, defaults to true.
#
# [*password_auth*]
#  Determines whether password authentication is allowed, defaults to false.
#
# [*privilege_separation*]
#  Enables privilege separation for the SSH daemon, defaults to true.
#
# [*protocol*]
#  The SSH protocol to use, defaults to 2.  May be a list, ordered by
#  accepted priority (e.g., `protocol => [2, 1]`).
#
# [*sftp*]
#  Whether or not to enable the SFTP subsystem, defaults to true.
#
# [*strict_modes*]
#  Determines whether the SSH daemon should check file permissions and
#  and ownership of the user's files and home directory before allowing
#  a login (e.g., checking whether ~/.ssh is world-readable).  Defaults
#  to true.
#
# [*syslog_facility*]
#  The syslog facility for the SSH daemon, defaults to 'AUTH'.
#
# [*tcp_forwarding*]
#  Allows TCP forwarding by the SSH daemon, defaults to false.
#
# [*tcp_keepalive*]
#  Determines whether TCP "keepalive" packets are sent to clients, defaults
#  to true.
#
# [*trusted_user_ca_keys*]
#  Specifies a file containing public keys of trusted CAs that are allowed
#  to sign user certificates for authentication (the TrustedUserCAKeys
#  sshd_config setting).
#
# [*use_dns*]
#  Whether or not the SSH daemon should perform name lookups on the remote
#  host and that it maps back, defaults to true.
#
# [*x11_forwarding*]
#  Allows X11 forwarding by the SSH daemon, defaults to false.
#
class sys::ssh(
  $port                         = 22,
  $listen_address               = undef,
  $acceptenv                    = [ 'LANG', 'LC_*' ],
  $agent_forwarding             = false,
  $allowusers                   = false,
  $allowgroups                  = false,
  $authorized_keys_command      = false,
  $authorized_keys_command_user = false,
  $authorized_keys_file         = false,
  $authorized_principals_file   = false,
  $denyusers                    = false,
  $denygroups                   = false,
  $challenge_response           = false,
  $ciphers                      = [],
  $empty_passwords              = false,
  $host_key_algorithms          = [],
  $kex_algorithms               = [],
  $login_grace_time             = 120,
  $log_level                    = 'INFO',
  $macs                         = [],
  $root_login                   = false,
  $rsa_auth                     = true,
  $pubkey_auth                  = true,
  $password_auth                = false,
  $privilege_separation         = true,
  $protocol                     = 2,
  $sftp                         = true,
  $strict_modes                 = true,
  $syslog_facility              = 'AUTH',
  $tcp_forwarding               = false,
  $tcp_keepalive                = true,
  $trusted_user_ca_keys         = false,
  $use_dns                      = true,
  $x11_forwarding               = false,
){
  validate_array(
    $acceptenv, $ciphers, $host_key_algorithms,
    $kex_algorithms, $macs
  )
  validate_bool(
    $agent_forwarding, $challenge_response, $empty_passwords, $password_auth,
    $privilege_separation, $pubkey_auth, $root_login, $rsa_auth, $sftp,
    $strict_modes, $tcp_forwarding, $tcp_keepalive, $use_dns, $x11_forwarding
  )
  validate_integer($port)
  validate_integer($login_grace_time)

  anchor { 'sys::ssh::start': }  ->
  class { 'sys::ssh::install': } ->
  class { 'sys::ssh::config': }  ->
  class { 'sys::ssh::service': } ->
  anchor { 'sys::ssh::end': }
}
