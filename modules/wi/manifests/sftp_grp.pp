define wi::sftp_grp(
	$sftp_grp,
	$sftp_dir = '/home/%u'
){
	concat::fragment{'sftp':
		target  		=> 	'/etc/ssh/sshd_config',
		content			=>	template('wi/sftp_grp_match.erb'),
		order			=>	02,
	}


}