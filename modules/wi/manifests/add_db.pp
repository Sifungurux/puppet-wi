define wi::add_db (
    $dbpriv = [ 'SELECT', 'UPDATE' ],
    $dbpass
    ){
  
  mysql::db { "${name}.1":
    user          => $name,
    password      => $dbpass,
    host          => 'localhost',
    grant         => $dbpriv,
  }

  mysql::db { "${name}.2":
    user          => $name,
    password      => $dbpass,
    host          => 'localhost',
    grant         => $dbpriv,
  }
}