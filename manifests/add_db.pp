# Class: wi::add_db
# ====================
# Function part of the WI class for delete of a user
#
# Parameters:
# [*dbpass*]
# [*dbpriv*]
# Examples
# --------
#
#
define wi::add_db ( String $dbpass, List $dbpriv = ['SELECT', 'UPDATE']) {
  mysql::db { "${name}_1":
    user     => $name,
    password => $dbpass,
    host     => 'localhost',
    grant    => $dbpriv,
  }

  mysql::db { "${name}_2":
    user     => $name,
    password => $dbpass,
    host     => 'localhost',
    grant    => $dbpriv,
  }
}
