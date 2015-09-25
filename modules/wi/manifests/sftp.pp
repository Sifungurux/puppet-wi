class add_sftp_user (
          $sftp_user,
          $sftp_user_pass,
          $sftp_group,
  
    ){
      
  group { $sftp_group :
    ensure        => present,
  }
  user { $sftp_user :
    ensure        => present,
    managehome    => true,
    groups        => [ $sftp_group],
    shell         => '/sbin/nologin',
    password      => $sftp_user_pass,
    require       => Group[ $sftp_group ],
        }
  file { "/home/${sftp_user}":
    ensure        => directory,
    recurse       => true,
    owner         => $sftp_user,
    group         => $sftp_group,
    mode          => '0644',
    require       => User[ $sftp_user ],
        }       
}
class setup_a_sftp_grp (
          $sftp_group,
          )
{
    file_line { 'sshd_config':
    notify    => Service["sshd"],
    path  => '/etc/ssh/sshd_config',
    line    => 'Subsystem sftp internal-sftp',
    match   => 'Subsystem sftp*',
  } 
  
  concat::fragment { "internal-chroot":
    target  => '/etc/ssh/sshd_config',
    content => template('sftp_grp_match.erb'),
    require => File_line['sshd_config'],
    notify  => Service['ssh'],
  }
  
  service { 'ssh':
    ensure        => running,
    enable        => true,
    }

  
  
}