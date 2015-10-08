define wi::webstudent(
    $host,
    $pass,
    $students_grants
){
  group { $name :
    ensure        => present,
    }
  group { 'sftp' :
    ensure        => present,
    require       => Group[ $name],
    }

  user { $name :
    ensure        => present,
    managehome    => true,
    groups        => [ $name, 'sftp' ],
    shell         => "/bin/bash",
    password      => pw_hash($pass, 'SHA-512', 'Macca'),
    require       => Group['sftp'],
    }
    
  file { "/home/${$name}":
    ensure        => directory,
    recurse       => true,
    owner         => $name,
    group         => 'sftp',
    mode          => '0644',
    require       => User[$name],
    }

  apache::vhost { $name :
    servername    => $host,
    port          => '80',
    docroot       => "/home/${name}",
    require       => File["/home/${$name}"],
    }
  mysql::db { "${name}.1":
    user          => $name,
    password      => $pass,
    host          => 'localhost',
    grant         => $students_grants,
  }

  mysql::db { "${name}.2":
    user          => $name,
    password      => $pass,
    host          => 'localhost',
    grant         => $students_grants,
  }
  
}
