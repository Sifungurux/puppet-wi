define  wi::sftp_user ( $sftp_user_pass, $sftp_group ){      
 
    group { $name :
      ensure        => present,
      }
   file { "/wi/${sftp_group}/${$name}":
      ensure        => directory,
      recurse       => true,
      owner         => 'root',
      group         => 'root',
      mode          => '0755',
      }
   
   file { "/wi/${sftp_group}/${$name}/web":
      ensure        => directory,
      recurse       => true,
      owner         => $name,
      group         => $name,
      mode          => '0755',
      require       => User[$name],
      }
      
    user { $name :
      ensure        => present,
      home          => "/web",
      managehome    => true,
      groups        => [ $name, $sftp_group ],
      shell         => "/usr/sbin/nologin",
      password      => pw_hash($sftp_user_pass, 'SHA-512', 'Macca'),
      #require       => File["/wi/${sftp_group}/${$name}/web"],
      }
    

              
}