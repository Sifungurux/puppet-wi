# Parameters:
# [*host*] Host
# [*pass*] USer password
# [*edu*] Training or exam - environement
# [*students_grants*] User db privleges 
#
define wi::webstudent (
  Integer $host,
  String $pass,
  String $edu,
  List $students_grants
) {
  $prefix = '' #this could be use to set a predefined path eg. /data/mdk/ before adding the wi/$name to it

  wi::add_user { $name : user_pass => $pass, group => $edu }
  wi::add_vhost { $name : vhost => $host, dir => "/wi/${edu}/${$name}/web" }
  wi::add_db { $name : dbpass => $pass, dbpriv => $students_grants, }
}
