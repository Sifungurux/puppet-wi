# Class function:
# [*wi::sftp_grp*]
# Parameters:
# [*sftp_grp*] SFTP Group for user
# [*sftp_dir*] SFTP folder for user
#
define wi::sftp_grp (
  String $sftp_grp,
  String $sftp_dir = '/home/%u'
) {
  concat::fragment { 'sftp':
    target  => '/etc/ssh/sshd_config',
    content => template('wi/sftp_grp_match.erb'),
    order   => 2 ,
  }
}
