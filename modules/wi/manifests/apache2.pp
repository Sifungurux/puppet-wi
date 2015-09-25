class add_web {
  
  include wi::qdd_sftp_user
  
    $username = $wi::add_sftp_user::sftp_user
    concat::fragment { "webadd":
    target  => '/etc/apache2/apache2.conf',
    content => template('addweb.erb'),
    }
    
    concat::fragment { "webVhost":
    target  => '/etc/apache2/sites-available/wi-${username}.conf',
    content => template('add_Vhost.erb'),
    }
    
    exec {'a2ensite':
      command   => 'a2ensite wi-${username}',
      path      => '/usr/sbin/',
    }
    
    service { 'apache2':
      ensure    => running,
      }
      
    exec { 'reload':
      command   => '/etc/init.d/apache2 reload',
      require   => Exec['a2ensite'],
    }
}