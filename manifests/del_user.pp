# Function part of the WI class for delete of a user
#
# Parameters:
# [*del_dir*]
#
define wi::del_user ( String $del_dir = false) {
  exec { "del_${name}" :
    command => "deluser ${name}",
    path    => '/usr/sbin/',
  }
  if $del_dir {
    exec { $del_dir :
      command => "rm -R ~${name}",
      path    => '/bin/',
    }
  }

  exec { "drop.db.${name}":
    command => "mysql -u root -e \"DROP DATABASE ${name}_1;\"",
    path    => '/usr/bin',
  }

  exec { "drop.db.${name}":
    command => "mysql -u root -e \"DROP DATABASE ${name}_2;\"",
    path    => '/usr/bin',
  }

  exec { "drop.${name}":
    command => "mysql -u root -e \"DROP USER '${name}'@'localhost';\"",
    path    => '/usr/bin',
  }
}
