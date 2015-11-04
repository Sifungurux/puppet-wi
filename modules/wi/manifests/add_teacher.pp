define wi::add_teacher(
  $password,
  ){
   mysql::db { "*.*":
    user            => $name,
    password        => $password,
    host            => 'localhost',
    grant           => 'ALL',
  }
    
   group { $name :
      ensure        => present,
      }
   file { "/wi/}":
      ensure        => directory,
      recurse       => true,
      owner         => 'root',
      group         => 'root',
      mode          => '0755',
      }
  
    user { $name :
      ensure        => present,
      home          => "/wi",
      managehome    => false,
      groups        => [ $name ],
      shell         => "/usr/sbin/nologin",
      password      => pw_hash($password, 'SHA-512', 'Macca'),
      #require       => File["/wi/${sftp_group}/${$name}/web"],
      }
  }