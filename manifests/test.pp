node 'test.kirk.local' {
	package { 'ntp':
		ensure => present,
      }
	
}
