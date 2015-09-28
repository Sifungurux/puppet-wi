#Manage webintergrates web development
class wi  (
    $rootPass   = 'm@cca9091'
    ){
# dependencies
# puppetlabs-apache
# puppetlabs-mysql
# puppetlabs-concat
# puppetlabs-stdlib

# Install these modules prier to to implement this module
  class { 'apache': mpm_module => 'prefork',}
  $php = [ "php5-cli", "libapache2-mod-php5", "php5-common", "php5-mysql", "php5-curl" ]
  package { $php: } 
  include apache::mod::php

  file_line { 'listen':
    notify    => Service["mysqld"],
    path  => '/etc/mysql/my.cnf',
    line    => 'bind-address = 0.0.0.0',
    match   => '^bind-address*',
  } 
 
  
  exec { "mysql root": 
    command => "/usr/bin/mysql -u root -e \"GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;\"",
    notify  => Service["mysqld"],
  }

}
          



