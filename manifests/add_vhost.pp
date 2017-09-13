define wi::add_vhost (
    $dir ='home',
    $vhost
    ){
  
    apache::vhost { $name :
    servername    => $vhost,
    port          => '80',
    docroot       => "${dir}",
    }
}