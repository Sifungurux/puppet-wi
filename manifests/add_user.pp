# Function part of the WI class for delete of a user
#
# Parameters:
# [*user_pass*]
# [*group*]
#
define wi::add_user ( String $user_pass, String $group ) {
  file { "/wi/${group}/${$name}":
    ensure  => directory,
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { "/wi/${group}/${$name}/web":
    ensure  => directory,
    recurse => true,
    owner   => $name,
    group   => $group,
    mode    => '0755',
    require => User[$name],
  }

  user { $name :
    ensure     => present,
    home       => '/web',
    managehome => true,
    groups     => $group,
    shell      => '/usr/sbin/nologin',
    password   => pw_hash($user_pass, 'SHA-512', 'Macca'),
    #require       => File["/wi/${sftp_group}/${$name}/web"],
  }
}
