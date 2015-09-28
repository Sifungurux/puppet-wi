define wi::sql{ 
  mysql::db { '$name':
    user     => '$name',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }
 
	
}