define wi::add_db (
    $dbpriv = [ 'SELECT', 'UPDATE' ],
    $dbpass
    ){
  
  mysql::db { "${name}_1":
    user          => $name,
    password      => $dbpass,
    host          => 'localhost',
    grant         => $dbpriv,
  }

  mysql::db { "${name}_2":
    user          => $name,
    password      => $dbpass,
    host          => 'localhost',
    grant         => $dbpriv,
  }
}