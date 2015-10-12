node wi1 {
	
	
	class {'wi':
	rootPass => 'm@cca9091',
	group     => ["edu","exam"],
	vhost_root_dir => 'wi',
	}
	

  wi::webstudent { 'student1': host => 'wi1', pass => '1234', students_grants => [ 'SELECT', 'UPDATE' ], edu => 'edu'}
  wi::webstudent { 'student2': host => 'wi2', pass => '1234', students_grants => [ 'SELECT', 'UPDATE' ], edu => 'edu'}
	#wi::sftp_grp{ 'sftp': sftp_grp => 'wi', sftp_dir => '/home/%u',}
	#wi::sftp_user{ 'new user': sftp_user_pass => 'password', sftp_group => 'sftp group',}
}











#/^wi[0-9]/ with regex node