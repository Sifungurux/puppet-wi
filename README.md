# WebIntergator-Server-client-setup

This small module is use to supply webintergrators students with server solutions for educational and for final exam

small example of declaring and adding a student

	class {'wi':
	rootPass => 'm@cca9091',
	group     => ["edu","exam"],
	vhost_root_dir => 'wi',
	}
	

  wi::webstudent { 'student1': host => 'wi1', pass => '1234', students_grants => [ 'SELECT', 'UPDATE' ], edu => 'edu'}
  wi::webstudent { 'student2': host => 'wi2', pass => '1234', students_grants => [ 'SELECT', 'UPDATE' ], edu => 'edu'}
