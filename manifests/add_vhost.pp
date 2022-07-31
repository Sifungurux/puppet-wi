# Function part of the WI class for delete of a user
#
# Parameters:
# [*dir*]
# [*vhost*]
#
define wi::add_vhost ( String $vhost, String $dir = 'home') {
  apache::vhost { $name :
    servername => $vhost,
    port       => '80',
    docroot    => $dir,
  }
}
