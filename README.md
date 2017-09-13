Declaring the WI CLASS
	
	class {'wi':
	rootPass => 'm@cca9091',
	group     => ["edu","exam"],
	vhost_root_dir => 'wi',
	}
	wi::add_teacher {'Pernille' : password => '1234'}

  wi::webstudent { 'student1': host => 'wi1', pass => '1234', students_grants => [ 'SELECT', 'UPDATE' ], edu => 'edu'}
  wi::webstudent { 'student2': host => 'wi2', pass => '1234', students_grants => [ 'SELECT', 'UPDATE' ], edu => 'edu'}
  #wi::del_user { 'student2': del_dir => true,}
	#wi::sftp_grp{ 'sftp': sftp_grp => 'wi', sftp_dir => '/home/%u',}
	#wi::sftp_user{ 'new user': sftp_user_pass => 'password', sftp_group => 'sftp group',}
}
