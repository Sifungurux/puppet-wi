node wi1 {
  
  $rootPass = 'M@cca9091'
  
  class { 'apache':  }

  class {'mysql::server':
    root_password   => 'M@cca9091',
 #   override_options => { 'client' => { 'user' => 'root', password => 'M@cca9091' }  },
    }
    
    
  wi::webstudent { 'student1': host => 'wi1', pass => '1234', students_grants => [ 'SELECT', 'UPDATE' ],}
  #wi::webstudent { 'student2':}
}











#/^wi[0-9]/ with regex node