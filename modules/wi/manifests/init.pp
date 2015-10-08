#Manage webintergrates web development
class wi  (
    $rootPass   = 'm@cca9091',
    $sftp_group = 'sftp',
	){
# dependencies
# puppetlabs-apache
# puppetlabs-mysql
# puppetlabs-concat
# puppetlabs-stdlib

# Install these modules prier to to implement this module
	class { 'apache': mpm_module => 'prefork',}
	class {'mysql::server':
		root_password 	  => 'M@cca9091',
		override_options  => { 'client' => { 'user' => 'root', password => 'M@cca9091' } },
	}
	class { 'phpmyadmin': } 
  
	$php = [ "php5-cli", "libapache2-mod-php5", "php5-common", "php5-mysql", "php5-curl" ]
	package { $php: } 
	include apache::mod::php

	file_line { 'listen':
		notify    		=> Service["mysqld"],
		path  			=> '/etc/mysql/my.cnf',
		line    		=> 'bind-address = 0.0.0.0',
		match   		=> '^bind-address*',
	} 
 
  
	exec { "mysql root": 
		command 		=> "/usr/bin/mysql -u root -e \"GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;\"",
		notify  		=> Service["mysqld"],
	}
	phpmyadmin::server{ 'default': }
  
	@@phpmyadmin::servernode { "${::ipaddress}":
		server_group 	=> 'default',
	}
	phpmyadmin::vhost { 'wi1.kirk.local':
		vhost_enabled 	=> true,
		priority      	=> '20',
		docroot       	=> $phpmyadmin::params::doc_path,
		ssl           	=> false,
		#ssl_cert      	=> 'puppet:///modules/phpmyadmin/sslkey/internal.domain.net.crt',
		#ssl_key       	=> 'puppet:///modules/phpmyadmin/sslkey/internal.domain.net.private.key',
	}
	concat{'/etc/ssh/sshd_config':
		ensure			=> 'present',
		owner       	=> 'root',
        group       	=> 'root',
    }	
	concat::fragment{'sshd_config':
		target  		=> '/etc/ssh/sshd_config',
		content 		=> template('wi/wi_sshd_config.erb'),
		order   		=> 01,
	}
	concat::fragment{'sftp':
		target  		=> 	'/etc/ssh/sshd_config',
		content			=>	template('wi/sftp_grp_match.erb'),
		order			=>	02,
	}

}
          



