class proftpd(
        $ipv6 = off,
        $identlookups = off,
        $server_name = $fqdn,
        $port = 21,
        $passiveports = 'default',
        $jail = false,
        $max_instances = 30,
        $allowgroup = udef,
        $directories = udef,
        $allow_overwrite = on,
        $limit_cmd = udef,
        $proftp_admin = 'proadmin',
        $proftp_adm_password = 4321,
        $proftp_group = 'FTP',
        $shell = '/bin/bash',
        ){

        package { 'proftpd':
          ensure        => installed,
        }

        service { 'proftpd':
          ensure        => running,
          enable        => true,
          require       => Package ['proftpd']
        }

        file_line {'Adding /bin/false to /etc/shells':
          path          => '/etc/shells',
          line          => $shell,
        }

        group { $proftp_group :
          ensure        => present,
        }
        group { $proftp_admin :
          ensure        => present,
          require       => Group[ $proftp_group ],
        }

        user { $proftp_admin :
          ensure        => present,
          managehome    => true,
          groups        => [ $proftp_admin, $proftp_group ],
          shell         => "/bin/bash",
          password      => $proftp_adm_password,
          require       => Group[ $proftp_admin ],
        }
    
            file { "/home/${proftp_admin}":
          ensure        => directory,
          recurse       => true,
          owner         => $proftp_admin,
          group         => $proftp_admin,
          mode          => 0644,
          require       => User[ $proftp_admin ],
        }
        file { '/etc/proftpd/proftpd.conf':
          content       => template('wi/proftpd.conf.erb'),
          owner         => root,
          group         => root,
          mode          => 644,
          notify        => Service['proftpd'],
        }

}