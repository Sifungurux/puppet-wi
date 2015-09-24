class SQL (
		$username,
		$user_passwd,
		$admin,
		$admin_pass,
		){
#### PHP ####

  $FORPHP = [ "php5-cli", "libapache2-mod-php5", "php5-common", "php5-mysql", "php5-curl" ]
  package { $FORPHP: }

  class { 'apache':
	mpm_module => 'prefork',
	}
	include apache::mod::php

#############

  class {'mysql::server':
	root_password 	=> '${rootPass}',
	override_options => { 'client' => { 'user' => 'root', password => '${rootPass}'  },
	}
  
  mysql::db { $username:
  	user     => $username,
	password => $user_passwd,
	}
  
  mysql::db { $admin:
  	user     => $admin,
	password => $admin_pass,
	}

	mysql_grant { '${username}@localhost/${username}.*':
  	ensure     => 'present',
  	options    => ['GRANT'],
  	privileges => ['ALL'],
  	table      => '*.*',
  	user       => '${username}@localhost',
	}
	mysql_grant { '${admin}@localhost/${username}.*':
  	ensure     => 'present',
  	options    => ['GRANT'],
  	privileges => ['ALL'],
  	table      => '*.*',
  	user       => '${admin}@localhost',
	}

    # file { "/tmp/RoleDB.sql":
  	# ensure => present,
  	# source => "puppet:///modules/role/RoleDB.sql",
	# }  
  
  file_line { 'listen':
    notify   	=> Service["mysqld"],
    path	=> '/etc/mysql/my.cnf',
    line  	=> 'bind-address = 0.0.0.0',
    match 	=> '^bind-address*',
	}	

  exec { "mysql root": 
	command => "/usr/bin/mysql -u root -e \"GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;\"",
	notify  => Service["mysqld"],
	}
	
}