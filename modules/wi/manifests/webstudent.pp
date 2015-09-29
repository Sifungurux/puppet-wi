define wi::webstudent(
    $host,
    $pass,
    $students_grants
){
  group { $name :
    ensure        => present,
    }
  group { 'admin' :
    ensure        => present,
    require       => Group[ $name],
    }

  user { $name :
    ensure        => present,
    managehome    => true,
    groups        => [ $name, 'admin' ],
    shell         => "/bin/bash",
    password      => pw_hash($pass, 'SHA-512', 'Macca'),
    require       => Group['admin'],
    }
    
  file { "/home/${$name}":
    ensure        => directory,
    recurse       => true,
    owner         => $name,
    group         => $name,
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
  
  phpmyadmin::server{ 'default': }

  phpmyadmin::vhost { 'wi1.kirk.local':
    vhost_enabled => true,
    priority      => '20',
    docroot       => $phpmyadmin::params::doc_path,
    ssl           => false,
    #ssl_cert      => 'puppet:///modules/phpmyadmin/sslkey/internal.domain.net.crt',
    #ssl_key       => 'puppet:///modules/phpmyadmin/sslkey/internal.domain.net.private.key',
  }
}
