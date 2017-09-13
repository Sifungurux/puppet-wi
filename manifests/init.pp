# Class: wi
# ===========================
#
# Full description of class wi here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'wi':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class wi {
 $rootPass,
    $group,
    $vhost_root_dir,
	){
# dependencies
# puppetlabs-apache
# puppetlabs-mysql
# puppetlabs-concat
# puppetlabs-stdlib

# Install these modules prier to to implement this module
    group {$group:
      ensure        => present,
      }
###########################################################
#                                                         #
#         Creation of directory structor                  #
#                                                         #
###########################################################
  file { "/${vhost_root_dir}":
    ensure => "directory",
  }  
  
  file { "/${vhost_root_dir}/${group[0]}":
    ensure => "directory",
    require   => File["/${vhost_root_dir}"],
    }

  file { "/${vhost_root_dir}/${group[1]}":
    ensure => "directory",
    require   => File["/${vhost_root_dir}"],
    }
    
 ###########################################################  
	 class {'mysql::server':
      root_password 	  => 'M@cca9091',
		  override_options  => { 'client' => { 'user' => 'root', password => 'M@cca9091' } },
		  }
   class { 'phpmyadmin': } 
  
	 $php = [ "php5", "php5-cli", "libapache2-mod-php5", "php5-common", "php5-mysql", "php5-curl" ]
	 package { $php :
	   ensure => "installed", 
    } 
    
  class { 'apache': mpm_module => 'prefork',}
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
    concat::fragment{ 'sftp' :
    target      =>  '/etc/ssh/sshd_config',
    content     =>  template('wi/sftp_grp_match.erb'),
    order     =>  02,
  }
}

}
